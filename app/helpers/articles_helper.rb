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
    "#{curr_feed.title} | #{current_article.author} | #{(Date.today - current_article.published.to_date).to_i} days ago"
  end
end