require 'rails_helper'

RSpec.describe SitemapRefreshJob, type: :job do
  include ActiveJob::TestHelper

  it "enqueues the job" do
    expect {
      SitemapRefreshJob.perform_later
    }.to have_enqueued_job(SitemapRefreshJob)
  end
end
