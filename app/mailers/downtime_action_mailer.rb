class DowntimeActionMailer < ActionMailer::Base
  def submit(character, period, storyteller)
    @character = character
    @period = period
    @storyteller = storyteller
    mail(
      :subject => "[AAL Character System] Downtime submission for #{@character.name} for #{@period.title}",
      :to  => @storyteller.email,
      :from => 'sts@askagainlater.com')
  end
end
