module ArticlesHelper
  def sandbox
  end

  def display_attr(attribute_name, current_article, separator = ', ', newline = true)
    unless (response = current_article.public_send(attribute_name)).nil?
      label = "#{attribute_name.capitalize}"
      newline_char = (newline ? '<br>' : '')
      case attribute_name
        when :relations
          display_set = "#{response}"
        else
          display_set = "#{response.keys.join(separator)}"
      end
      "#{label}: #{display_set}#{newline_char}"
    else
      ''
    end
  end

  def display_tag_attrs(current_article)
    tag_attrs = [:tags, :entities, :locations, :relations]
    str = ''
    tag_attrs.each do |ta|
      str << display_attr(ta, current_article)
    end
    str
  end

  def display_footer_attrs(current_article)
    curr_feed = Feed.find(current_article.feed_id)
    "#{curr_feed.title} | #{current_article.author} | #{time_since_published(current_article.published)}"
  end

  def time_since_published(published)
    days_since = (Date.today - published.to_date).to_i
    if days_since > 0
      return "#{days_since} days ago"
    else
      hours_since = (DateTime.now.hour - published.hour).to_i
      if hours_since > 0
        return "#{hours_since} hours ago"
      else
        minutes_since = (DateTime.now.minute - published.minute).to_i
        return "#{minutes_since} minutes ago"
      end
    end
  end
end