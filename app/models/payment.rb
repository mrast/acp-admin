class Payment < ActiveRecord::Base
  include HasFiscalYearScopes

  attr_accessor :comment

  acts_as_paranoid

  default_scope { order(:date) }

  belongs_to :member
  belongs_to :invoice, optional: true

  scope :isr, -> { where.not(isr_data: nil) }
  scope :manual, -> { where(isr_data: nil) }
  scope :invoice_id_eq, ->(id) { where(invoice_id: id) }

  validates :date, presence: true
  validates :amount, numericality: { other_than: 0 }, presence: true
  validates :isr_data, uniqueness: true, allow_nil: true

  after_commit :update_invoices_balance

  def self.update_invoices_balance!(member_id)
    member = Member.find(member_id)
    remaining_amount = 0

    transaction do
      member.invoices.update_all(balance: 0)

      # Use payment amount to targeted invoice first.
      member.payments.each do |payment|
        if payment.invoice && !payment.invoice.canceled?
          balance = [payment.amount, payment.invoice.missing_amount].min
          payment.invoice.increment!(:balance, balance)
          remaining_amount += payment.amount - balance
        else
          remaining_amount += payment.amount
        end
      end

      # Split remaining amount on other invoices chronogically
      invoices = member.invoices.not_canceled.order(:date)
      last_invoice = invoices.last
      invoices.each do |invoice|
        if remaining_amount.positive?
          balance = invoice == last_invoice ? remaining_amount : [remaining_amount, invoice.missing_amount].min
          invoice.increment!(:balance, balance)
          remaining_amount -= balance
        end
        invoice.reload.close_or_open!
      end
    end
  end

  def invoice_id=(invoice_id)
    super
    self.invoice = invoice if invoice
  end

  def invoice=(invoice)
    self.member = invoice.member
    super
  end

  def type
    isr_data? ? 'isr' : 'manual'
  end

  def isr?
    type == 'isr'
  end

  def manual?
    type == 'manual'
  end

  def self.ransackable_scopes(_auth_object = nil)
    %i[invoice_id_eq]
  end

  def can_destroy?
    manual?
  end

  def can_update?
    manual?
  end

  private

  def update_invoices_balance
    self.class.update_invoices_balance!(member_id)
  end
end
