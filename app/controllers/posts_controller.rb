class PostsController < SessionsController
  before_action :check_current_user

  def index
    @posts = Post.all
    @tags = Tag.all
  end
  
  def new
  end

  def show
    @post = Post.find(params[:id])
    @comments = Comment.where(post_id: params[:id]).order(:created_at)
    @comments.each do |comment|
      add_attribute(comment, :from_nickname)
      comment.from_nickname = update_nickname(@post, comment.from_user_id)
      add_attribute(comment, :to_nickname)
      comment.to_nickname = update_nickname(@post, comment.to_user_id)
    end
    @to_comment_id = params[:to_comment_id]
    @to_user_id = params[:to_user_id]
  end
  
  def create
<<<<<<< HEAD
    post = @current_user.posts.create(post_info)
    if post
      # update_nickname(post, @current_user.id)
      # group = post.group.create
      group = Group.create
      group.id=post.id
=======

    tag_name_list = Array[post_info[:tag1], post_info[:tag2], post_info[:tag3]]
    puts tag_name_list
    puts 'HI!!!!!!!'

    tag_name_list.each do |tag_name|

      if tag_name == ""
        tag_name = "other"
      end
      puts tag_name
      tmp_tag = Tag.find_by(name: tag_name)
      if tmp_tag == nil
        tmp_tag = Tag.create(name: tag_name, freq: 0)
      end
    
    end
    
    puts "ye!!!!!!"
    puts Tag.find_by(name: "other")

    # tmp_tag = Tag.find_by(name: post_info[:tag1])

    # if tmp_tag == nil
    #   tmp_tag = Tag.create(name: post_info[:tag1], freq: 0)
    # else
    #   # tmp_tag.freq = tmp_tag.freq + 1
    #   puts 'HI!!!!!!'

    #   puts tmp_tag.name
    #   # tmp_tag.update(freq: tmp_tag.freq + 1)
    #   puts tmp_tag.freq

    #   # tmp_tag.save
    # end
     
    post = @current_user.posts.create(post_info)
    if post
      # post.update(tag1: tmp_tag.name)
      post.update(tag1: tag_name_list[0],tag2: tag_name_list[1],tag3: tag_name_list[2])
      post.save
>>>>>>> abdd79d5ca3259b72eafffd933e77e60486ca167
      redirect_to posts_path
    else
      render 'new'
    end
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    redirect_to posts_path
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])
    @post.update_attributes(post_info)
    redirect_to posts_path
  end
  
  private
  def post_info
<<<<<<< HEAD
    params.require(:post).permit(:title, :content, :start, :end, :low_number, :high_number)
  end

  def get_nickname(id)
    cnt = Nickname.count
    name = Nickname.find(((id-1)%cnt)+1).name
    if (id-1)/cnt>0
      name += '.' + (id/cnt).to_s
    end
    return name
  end

  def update_nickname(post, user_id)
    if user_id == nil or user_id == ""
      return nil
    end
    if post.user_id == user_id
      return "Host"
    end
    nickname_id = nil
    assoc = PostUserNickname.find_by(post_id: post.id, user_id: user_id)
    if not assoc
      PostUserNickname.create(post_id: post.id, user_id: user_id, nickname_id: post.next_nickname_id)
      nickname_id = post.next_nickname_id
      post.next_nickname_id += 1
      post.save
    else
      nickname_id = assoc.nickname_id
    end
    return get_nickname(nickname_id)
=======
    params.require(:post).permit(:title, :content, :tag1, :tag2, :tag3)
>>>>>>> abdd79d5ca3259b72eafffd933e77e60486ca167
  end

  def add_attribute(klass, symbol)
    codes = %Q{
      def #{symbol}
        return @#{symbol}
      end

      def #{symbol}=(value)
        @#{symbol} = value
      end
    }

    klass.instance_eval(codes)
end

end
