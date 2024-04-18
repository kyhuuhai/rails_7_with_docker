class SendMailLoginSuccessJob
  include Sidekiq::Job
  queue_as :high

  def perform(*args)
    puts args
  end
end
