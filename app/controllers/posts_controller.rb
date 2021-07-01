class PostsController < ApplicationController
  before_action :set_post, only: %i[ show edit update destroy ]

    # GET /posts or /posts.json
    def index
      @posts = Post.all
    end

    # GET /posts/1 or /posts/1.json
    def show

     @favorite = current_user.favorites.find_by(post_id: @post.id)
    end

    # GET /posts/new
    def new
      if params[:back]
      @post = Post.new(post_params)
    else
      @post = current_user.posts.build
      @user = @post.user
    end
  end

    # GET /posts/1/edit
    def edit
      @user = @post.user
    end

    # POST /posts or /posts.json
    def create
      @post = Post.new(post_params)
      @post.user_id = current_user.id

      respond_to do |format|
        if @post.save
          PostMailer.post_mail(@post).deliver
          format.html { redirect_to post_path @post, notice: "Post was successfully created." }
          format.json { render :show, status: :created, location: @post }
        else
          format.html { render :new, status: :unprocessable_entity }
          format.json { render json: @post.errors, status: :unprocessable_entity }
        end
      end
    end
    def confirm
      @post = current_user.posts.build(post_params)
      @user = @post.user
        render :new if @post.invalid?
      end
    # PATCH/PUT /posts/1 or /posts/1.json
    def update
      @user = @post.user
        if @post.update(post_params)
          format.html { redirect_to_post_path @post, notice: "Post was successfully updated." }
          format.json { render :show, status: :ok, location: @post }
        else
          format.html { render :edit, status: :unprocessable_entity }
          format.json { render json: @post.errors, status: :unprocessable_entity }
        end
      end
    end

    # DELETE /posts/1 or /posts/1.json
    def destroy
      @user=@post.user_id
      @post.destroy
      respond_to do |format|
        format.html { redirect_to posts_url, notice: "Post was successfully destroyed." }
        format.json { head :no_content }
      end
    end

    private
      # Use callbacks to share common setup or constraints between actions.
      def set_post
        @post = Post.find(params[:id])
      end

      # Only allow a list of trusted parameters through.
      def post_params
        params.require(:post).permit(:caption, :image, :image_cache)
      end
