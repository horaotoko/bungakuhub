require 'grit'
class Kommit < ActiveRecord::Base
  attr_accessor :bare
  attr_accessible :message, :revision, :bare

  has_many :branch_kommits, dependent: :destroy
  has_many :branches, through: :branch_kommits, uniq: true
  belongs_to :user
  validates :message, presence: true


  def repository
    self.branches.first.repository
  end

  def info
    self.repository.repo.commits(self.revision).first
  end

  def revert(branch="master")
    Dir.chdir(self.repository.working_dir) do
      system("git checkout #{branch}")
      system("git revert --no-edit #{self.revision}")
    end
  end

  def git_message
    self.info.message.force_encoding("UTF-8")
  end

  def git_revision
    self.info.id
  end

  def contents
    self.info.tree.contents
  end

  def head?(branch='master')
    self.revision == self.repository.repo.commits(branch).first.id
  end



end
