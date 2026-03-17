-- CreateTable
CREATE TABLE "users" (
    "id" UUID NOT NULL DEFAULT gen_random_uuid(),
    "google_id" TEXT NOT NULL,
    "fullname" TEXT NOT NULL,
    "username" TEXT NOT NULL,
    "email" TEXT NOT NULL,
    "description" TEXT,
    "picture" TEXT,
    "is_verified" BOOLEAN NOT NULL DEFAULT false,
    "followers_count" INTEGER NOT NULL DEFAULT 0,
    "following_count" INTEGER NOT NULL DEFAULT 0,
    "available_votes" INTEGER NOT NULL DEFAULT 0,
    "votes_cast_count" INTEGER NOT NULL DEFAULT 0,
    "votes_received_count" INTEGER NOT NULL DEFAULT 0,
    "registered_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "last_login_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "users_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "publish_states" (
    "id" UUID NOT NULL DEFAULT gen_random_uuid(),
    "code" TEXT NOT NULL,
    "display" TEXT NOT NULL,
    "description" TEXT NOT NULL,

    CONSTRAINT "publish_states_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "categories" (
    "id" UUID NOT NULL DEFAULT gen_random_uuid(),
    "code" TEXT NOT NULL,
    "display" TEXT NOT NULL,
    "description" TEXT,

    CONSTRAINT "categories_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "tags" (
    "id" UUID NOT NULL DEFAULT gen_random_uuid(),
    "value" TEXT NOT NULL,
    "usage_count" INTEGER NOT NULL DEFAULT 0,

    CONSTRAINT "tags_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "remix_merge_states" (
    "id" UUID NOT NULL DEFAULT gen_random_uuid(),
    "code" TEXT NOT NULL,
    "display" TEXT NOT NULL,
    "description" TEXT,

    CONSTRAINT "remix_merge_states_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "wishes" (
    "id" UUID NOT NULL DEFAULT gen_random_uuid(),
    "owner_id" UUID NOT NULL,
    "publish_state_id" UUID NOT NULL,
    "publish_state_reason" TEXT,
    "votes_count" INTEGER NOT NULL DEFAULT 0,
    "remixes_count" INTEGER NOT NULL DEFAULT 0,
    "merged_remixes_count" INTEGER NOT NULL DEFAULT 0,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "wishes_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "wish_versions" (
    "id" UUID NOT NULL DEFAULT gen_random_uuid(),
    "wish_id" UUID NOT NULL,
    "version" INTEGER NOT NULL,
    "title" TEXT NOT NULL,
    "description" TEXT NOT NULL,
    "source_remix_id" UUID,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "wish_versions_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "wish_comments" (
    "id" UUID NOT NULL DEFAULT gen_random_uuid(),
    "owner_id" UUID NOT NULL,
    "wish_id" UUID NOT NULL,
    "parent_comment_id" UUID,
    "content" TEXT NOT NULL,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "wish_comments_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "wish_categories" (
    "wish_version_id" UUID NOT NULL,
    "category_id" UUID NOT NULL,
    "added_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "wish_categories_pkey" PRIMARY KEY ("wish_version_id","category_id")
);

-- CreateTable
CREATE TABLE "wish_tags" (
    "wish_version_id" UUID NOT NULL,
    "tag_id" UUID NOT NULL,
    "added_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "wish_tags_pkey" PRIMARY KEY ("wish_version_id","tag_id")
);

-- CreateTable
CREATE TABLE "wish_votes" (
    "wish_id" UUID NOT NULL,
    "user_id" UUID NOT NULL,
    "registered_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "wish_votes_pkey" PRIMARY KEY ("wish_id","user_id")
);

-- CreateTable
CREATE TABLE "remixes" (
    "id" UUID NOT NULL DEFAULT gen_random_uuid(),
    "owner_id" UUID NOT NULL,
    "wish_id" UUID NOT NULL,
    "title" TEXT NOT NULL,
    "description" TEXT NOT NULL,
    "votes_count" INTEGER NOT NULL DEFAULT 0,
    "merge_state_id" UUID NOT NULL,
    "publish_state_id" UUID,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "remixes_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "remix_comments" (
    "id" UUID NOT NULL DEFAULT gen_random_uuid(),
    "owner_id" UUID NOT NULL,
    "remix_id" UUID NOT NULL,
    "parent_comment_id" UUID,
    "content" TEXT NOT NULL,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "remix_comments_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "remix_categories" (
    "remix_id" UUID NOT NULL,
    "category_id" UUID NOT NULL,
    "added_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "remix_categories_pkey" PRIMARY KEY ("remix_id","category_id")
);

-- CreateTable
CREATE TABLE "remix_tags" (
    "remix_id" UUID NOT NULL,
    "tag_id" UUID NOT NULL,
    "added_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "remix_tags_pkey" PRIMARY KEY ("remix_id","tag_id")
);

-- CreateTable
CREATE TABLE "remix_votes" (
    "remix_id" UUID NOT NULL,
    "user_id" UUID NOT NULL,
    "registered_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "remix_votes_pkey" PRIMARY KEY ("remix_id","user_id")
);

-- CreateTable
CREATE TABLE "follows" (
    "user_id" UUID NOT NULL,
    "follower_id" UUID NOT NULL,
    "followed_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "follows_pkey" PRIMARY KEY ("user_id","follower_id")
);

-- CreateIndex
CREATE UNIQUE INDEX "users_google_id_key" ON "users"("google_id");

-- CreateIndex
CREATE UNIQUE INDEX "users_username_key" ON "users"("username");

-- CreateIndex
CREATE UNIQUE INDEX "users_email_key" ON "users"("email");

-- CreateIndex
CREATE INDEX "users_fullname_idx" ON "users"("fullname");

-- CreateIndex
CREATE INDEX "users_username_idx" ON "users"("username");

-- CreateIndex
CREATE UNIQUE INDEX "publish_states_code_key" ON "publish_states"("code");

-- CreateIndex
CREATE UNIQUE INDEX "publish_states_display_key" ON "publish_states"("display");

-- CreateIndex
CREATE UNIQUE INDEX "categories_code_key" ON "categories"("code");

-- CreateIndex
CREATE UNIQUE INDEX "categories_display_key" ON "categories"("display");

-- CreateIndex
CREATE UNIQUE INDEX "tags_value_key" ON "tags"("value");

-- CreateIndex
CREATE INDEX "tags_value_idx" ON "tags"("value");

-- CreateIndex
CREATE UNIQUE INDEX "remix_merge_states_code_key" ON "remix_merge_states"("code");

-- CreateIndex
CREATE UNIQUE INDEX "remix_merge_states_display_key" ON "remix_merge_states"("display");

-- CreateIndex
CREATE INDEX "wishes_owner_id_idx" ON "wishes"("owner_id");

-- CreateIndex
CREATE INDEX "wishes_publish_state_id_idx" ON "wishes"("publish_state_id");

-- CreateIndex
CREATE INDEX "wish_versions_source_remix_id_idx" ON "wish_versions"("source_remix_id");

-- CreateIndex
CREATE UNIQUE INDEX "wish_versions_wish_id_version_key" ON "wish_versions"("wish_id", "version");

-- CreateIndex
CREATE INDEX "wish_comments_wish_id_idx" ON "wish_comments"("wish_id");

-- CreateIndex
CREATE INDEX "wish_comments_parent_comment_id_idx" ON "wish_comments"("parent_comment_id");

-- CreateIndex
CREATE INDEX "remixes_wish_id_idx" ON "remixes"("wish_id");

-- CreateIndex
CREATE INDEX "remix_comments_remix_id_idx" ON "remix_comments"("remix_id");

-- CreateIndex
CREATE INDEX "remix_comments_parent_comment_id_idx" ON "remix_comments"("parent_comment_id");

-- AddForeignKey
ALTER TABLE "wishes" ADD CONSTRAINT "wishes_owner_id_fkey" FOREIGN KEY ("owner_id") REFERENCES "users"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "wishes" ADD CONSTRAINT "wishes_publish_state_id_fkey" FOREIGN KEY ("publish_state_id") REFERENCES "publish_states"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "wish_versions" ADD CONSTRAINT "wish_versions_wish_id_fkey" FOREIGN KEY ("wish_id") REFERENCES "wishes"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "wish_versions" ADD CONSTRAINT "wish_versions_source_remix_id_fkey" FOREIGN KEY ("source_remix_id") REFERENCES "remixes"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "wish_comments" ADD CONSTRAINT "wish_comments_owner_id_fkey" FOREIGN KEY ("owner_id") REFERENCES "users"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "wish_comments" ADD CONSTRAINT "wish_comments_wish_id_fkey" FOREIGN KEY ("wish_id") REFERENCES "wishes"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "wish_comments" ADD CONSTRAINT "wish_comments_parent_comment_id_fkey" FOREIGN KEY ("parent_comment_id") REFERENCES "wish_comments"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "wish_categories" ADD CONSTRAINT "wish_categories_wish_version_id_fkey" FOREIGN KEY ("wish_version_id") REFERENCES "wish_versions"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "wish_categories" ADD CONSTRAINT "wish_categories_category_id_fkey" FOREIGN KEY ("category_id") REFERENCES "categories"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "wish_tags" ADD CONSTRAINT "wish_tags_wish_version_id_fkey" FOREIGN KEY ("wish_version_id") REFERENCES "wish_versions"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "wish_tags" ADD CONSTRAINT "wish_tags_tag_id_fkey" FOREIGN KEY ("tag_id") REFERENCES "tags"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "wish_votes" ADD CONSTRAINT "wish_votes_wish_id_fkey" FOREIGN KEY ("wish_id") REFERENCES "wishes"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "wish_votes" ADD CONSTRAINT "wish_votes_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "users"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "remixes" ADD CONSTRAINT "remixes_owner_id_fkey" FOREIGN KEY ("owner_id") REFERENCES "users"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "remixes" ADD CONSTRAINT "remixes_wish_id_fkey" FOREIGN KEY ("wish_id") REFERENCES "wishes"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "remixes" ADD CONSTRAINT "remixes_merge_state_id_fkey" FOREIGN KEY ("merge_state_id") REFERENCES "remix_merge_states"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "remixes" ADD CONSTRAINT "remixes_publish_state_id_fkey" FOREIGN KEY ("publish_state_id") REFERENCES "publish_states"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "remix_comments" ADD CONSTRAINT "remix_comments_owner_id_fkey" FOREIGN KEY ("owner_id") REFERENCES "users"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "remix_comments" ADD CONSTRAINT "remix_comments_remix_id_fkey" FOREIGN KEY ("remix_id") REFERENCES "remixes"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "remix_comments" ADD CONSTRAINT "remix_comments_parent_comment_id_fkey" FOREIGN KEY ("parent_comment_id") REFERENCES "remix_comments"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "remix_categories" ADD CONSTRAINT "remix_categories_remix_id_fkey" FOREIGN KEY ("remix_id") REFERENCES "remixes"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "remix_categories" ADD CONSTRAINT "remix_categories_category_id_fkey" FOREIGN KEY ("category_id") REFERENCES "categories"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "remix_tags" ADD CONSTRAINT "remix_tags_remix_id_fkey" FOREIGN KEY ("remix_id") REFERENCES "remixes"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "remix_tags" ADD CONSTRAINT "remix_tags_tag_id_fkey" FOREIGN KEY ("tag_id") REFERENCES "tags"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "remix_votes" ADD CONSTRAINT "remix_votes_remix_id_fkey" FOREIGN KEY ("remix_id") REFERENCES "remixes"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "remix_votes" ADD CONSTRAINT "remix_votes_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "users"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "follows" ADD CONSTRAINT "follows_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "users"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "follows" ADD CONSTRAINT "follows_follower_id_fkey" FOREIGN KEY ("follower_id") REFERENCES "users"("id") ON DELETE RESTRICT ON UPDATE CASCADE;
