require 'open-uri'

module AccountHelper
  def sandbox
    # Article.all.each do |a|
    #   GetContentJob.perform_later(129)
    # end
    # GetContentJob.perform_later
    #     # Preview display of web page (DONT REMOVE THIS BLOCK)

    hash = Hash.new
    Article.all.each do |a|
      a.topics.each do |k, v|
        if v.to_f > 0.8
          if hash[k].nil?
            hash[k] = 1
          else
            hash[k] += 1
          end
        end
      end
    end
    hash.sort_by { |k, v| -v }[0..30].to_h


    # hash.each do |k,v|
    #   puts "#{k}: #{v}"
    # end
    #     # content.html.to_s.html_safe
    #
        # source = Article.where(:id => 25).url
        # content = Readability::Document.new(source, :tags => %w[div p]).content
        # strip_tags(content).to_s.html_safe
        # response = OpenCalaisClient.client.enrich(content)
    # # # #     response.raw.inspect
    # #     response.topics.each{|t| puts t[:name]}
    #     content
    # client = FeedlrClient.client
    # Feed.where(:id => 19).first.articles.each do |a|
    #   GetContentJob.perform_later(a.id)
    #   GetTagsJob.perform_later(a.id)
    # end

  end
  end
