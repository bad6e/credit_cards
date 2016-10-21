desc 'Set Reward'
task set_reward: :environment do
  Card.find(14).rewards.each do |reward|
    reward.update!(cent_value: 0.01)
    reward.update!(dollar_amount: reward.cent_value * reward.amount)
  end
end
