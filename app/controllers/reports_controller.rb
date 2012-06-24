
class ReportsController < ApplicationController
  def show
    #top 10 posts
    @posts = Post.find_by_sql("select  *,(select count(id) from comments where post_id = p.id) as vote from posts p

       order by vote desc, created_at desc")

    @userstats = []
    @userstats = User.find_by_sql("select id,
                                  username,
                              (select count(id) from comments where user_id = u.id) as totalcomments,
                              (select count(id) from posts where user_id = u.id) as totalposts,
                              (select updated_at  from posts where user_id = u.id order by updated_at  desc limit 1) as post_date,
                              (select  updated_at  from comments where user_id = u.id order by updated_at  desc limit 1) as comment_date
                              from users u

       order by totalposts desc, totalcomments desc limit 10 ")


  end
end
