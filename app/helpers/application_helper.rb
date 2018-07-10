module ApplicationHelper
  # @param [String, Array<String>] If it is a string, then just check that string, otherwise try all the strings.
  # @return [String] Either "active" or the empty string
  def class_for_menu(cmd)
    if String === cmd
      active_nav_menu == cmd ? "active" : ""
    else
      cmd.include?(active_nav_menu) ? "active" : ""
    end
  end

  # @param [String] status
  def status_bg_class(status)
    if status.downcase == "error"
      "bg-danger"
    elsif status.downcase == "pending"
      "bg-warning"
    else
      "bg-success"
    end
  end

  def app_version
    "1.0.0"
  end

  def pagination_link_to(label, page, path)
    if page
      content_tag("li", class: "page-item") do
        link_to label, path.merge(page_nr: page), class: "page-link"
      end
    else
      content_tag("li", class: "page-item disabled") do
        link_to label, "#", class: "page-link"
      end
    end
  end

  def link_to_language(locale)
    path = {controller: controller_name, action: action_name}.
        merge(request.request_parameters).
        merge(locale: locale)
    language = t('language', locale: locale)
    link_to(path, class: "dropdown-item") do
      image_tag("flags/#{locale}.png", alt: language) + content_tag(:span, language, class: 'ml-1')
    end
  end

  def flag_to_s(flag)
    if flag
      I18n.t("boolean.ja")
    else
      I18n.t("boolean.nein")
    end
  end

end
