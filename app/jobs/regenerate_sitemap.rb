class RegenerateSitemap
  include Delayed::RecurringJob
  run_every 1.day
  priority '0'
  run_at '11:00pm'
  timezone 'US/Pacific'
  queue 'Sitemap'

  def perform
    Rails.env.production? ? ( system 'rake sitemap:refresh' ) : ( system 'rake sitemap:refresh:no_ping' )
  end
end
