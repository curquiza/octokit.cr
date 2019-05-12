module Octokit
  module Models
    struct TeamDiscussion
      rest_model(
        author: User,
        body: String,
        body_html: String,
        body_version: String,
        comments_count: Int32,
        comments_url: String,
        created_at: String,
        last_edited_at: String,
        html_url: String,
        node_id: String,
        number: Int32,
        pinned: Bool,
        private: Bool,
        team_url: String,
        title: String,
        updated_at: String,
        url: String,
        reactions: Reactions
      )
    end

    struct DiscussionListOptions
      rest_model(
        direction: String
      )
    end
  end
end
