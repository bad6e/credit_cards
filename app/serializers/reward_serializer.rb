class RewardSerializer < ActiveModel::Serializer
  attributes :id, :amount, :record_date, :dollar_amount, :cent_value, :apply_link
end
