class Gossip < ApplicationRecord
	belongs_to :user
	has_many :join_table_gossip_tags
	has_many :tags, through: :join_table_gossip_tags
	has_many :comments
	has_many :likes

	validates :title, presence: true, length: { in: 3..14 }
	validates :content, presence: true
end
