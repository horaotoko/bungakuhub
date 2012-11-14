module Admin
  class RevertsController < ApplicationController

    def create
      @kommit = Kommit.find(params[:kommit_id])
      Dir.chdir(@kommit.repository.working_dir) do
        system("git revert --no-edit #{@kommit.revision}")
      end
      current_head = @kommit.repository.repo.commits.first
      kommit = Kommit.new(message:current_head.message.force_encoding("UTF-8"),
                         revision:current_head.id)
      branch = Branch.find(params[:branch_id])
      kommit.skip_callback = true
      kommit.save
      branch.kommits << kommit
      current_head.contents.each do |content|
        Post.create(skip_callback: true,
                    branch: branch,
                    title: content.name,
                    body: content.data)
      end
      
      redirect_to user_admin_repository_branch_kommits_path(params[:user_id], params[:repository_id], params[:branch_id])
    end
  
  end
end
