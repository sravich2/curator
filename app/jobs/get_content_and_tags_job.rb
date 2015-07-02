class GetContentAndTagsJob < ActiveJob::Base
  queue_as :default

  def perform(*args)
    puts 'Works as expected'
  end
end
