require 'feedlr'
module AccountHelper
  def sandbox
    populate_articles
    # User.find(id = 1).subscriptions.pretty_print_inspect
  end
end
