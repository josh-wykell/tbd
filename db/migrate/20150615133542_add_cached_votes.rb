class AddCachedVotes < ActiveRecord::Migration
  def change
    add_column :links, :cached_votes_total, :integer, :default => 0
    add_column :links, :cached_votes_score, :integer, :default => 0
    add_column :links, :cached_votes_up, :integer, :default => 0
    add_column :links, :cached_votes_down, :integer, :default => 0
    add_column :links, :cached_weighted_score, :integer, :default => 0
    add_column :links, :cached_weighted_total, :integer, :default => 0
    add_column :links, :cached_weighted_average, :float, :default => 0.0
    add_index  :links, :cached_votes_total
    add_index  :links, :cached_votes_score
    add_index  :links, :cached_votes_up
    add_index  :links, :cached_votes_down
    add_index  :links, :cached_weighted_score
    add_index  :links, :cached_weighted_total
    add_index  :links, :cached_weighted_average

    # Uncomment this line to force caching of existing votes
     Link.find_each(&:update_cached_votes)
  end
end
