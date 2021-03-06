module ApplicationHelper
  def spaced(string, size: 3)
    string = string.to_s
    (size - string.length).times do
      string = "&emsp;#{string}"
    end
    string.html_safe
  end

  def text_format(text)
    simple_format(text) if text.present?
  end

  def display_emails(emails)
    Array(emails).map { |email| mail_to(email) }.join(', ').html_safe
  end

  def display_phones(phones)
    Array(phones).map { |phone|
      link_to(
        phone.phony_formatted,
        "tel:" + phone.phony_formatted(spaces: '', format: :international))
    }.join(', ').html_safe
  end

  def display_price_description(price, description)
    "#{number_to_currency(price)} #{"(#{description})" if price.positive?}"
  end

  def any_basket_complements?
    BasketComplement.any?
  end

  def seasons_collection
    ACP.seasons.map { |season| [I18n.t("season.#{season}"), season] }
  end

  def referer_filter_member_id
    return unless request&.referer
    query = URI(request.referer).query
    Rack::Utils.parse_nested_query(query).dig('q', 'member_id_eq')
  end
end
