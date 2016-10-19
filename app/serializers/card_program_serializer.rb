class CardProgramSerializer < ActiveModel::Serializer
  attributes :id, :name, :image_url
  has_many :transfer_partners
end