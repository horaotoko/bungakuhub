class Post < ActiveRecord::Base
  attr_accessor :delete, :bare
  attr_accessible :body, :title, :delete, :bare
  belongs_to :branch

  validates :title, presence: true, length: {maximum:30},
                    uniqueness: {scope: :branch_id}

  def delete_file
    repository = self.branch.repository
    File.unlink("#{repository.working_dir}/#{self.title}")
  end

  def remove_index
    repository = self.branch.repository
    repository.repo.remove("#{self.title}")
  end

  def path
    repository = self.branch.repository
    "#{repository.working_dir}/#{self.title}"
  end
end
