#coding: utf-8
module NavigationHelpers
  #Maps a name to a path.

  def path_to(page_name)
    case page_name

    when /トップページ/
      '/'
    when /ログインページ/
      new_user_session_path
    when /ユーザ登録ページ/
      new_user_registration_path
    when /テキストレポジトリ作成ページ/
      new_text_repository_path
    when /自分のプロフィール編集ページ/
      edit_user_path(@current_user)
    when /^(.*)のプロフィール編集ページ$/
      @user = User.find_by_display_name($1)
      edit_user_path(@user)
    when /^(.*)のレポジトリ管理ページ$/
      @user = User.find_by_display_name($1)
      user_admin_repositories_path(@user)
    when /^(.*)のレポジトリ詳細ページ$/
      repo = Repository.find_by_name($1)
      user_admin_repository_path(repo.user, repo)
    when /^(.*)のレポジトリ編集ページ$/
      repo = Repository.find_by_name($1)
      edit_user_admin_repository_path(repo.user, repo)
    when /^(.*)のブランチ作成ページ$/
      repo = Repository.find_by_name($1)
      new_user_admin_repository_branch_path(repo.user, repo)
    else
      raise "\"#{page_name}\"にあたるpathが見当たりませんでした．"
    end
  end
end

World(NavigationHelpers)
