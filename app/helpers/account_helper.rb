require 'feedlr'
module AccountHelper
  def sandbox
    populate_feeds
    # User.find(id = 1).feeds.pretty_print_inspect
  end
end
