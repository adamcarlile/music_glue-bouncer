require_relative "test_helper"

describe MusicGlue::Bouncer do
  include Rack::Test::Methods

  context "session_sync_nonce" do
    before do
      @app = app_with_bouncer do
        {
          session_sync_nonce: 'session_nonce'
        }
      end
    end

    context "when a user is logged in" do
      before do
        set_cookie 'session_nonce=ABC'
        get '/hi'
        follow_successful_oauth!
        follow_redirect!
        assert_equal 'hi', last_response.body
      end

      context "and visits the app with a different nonce in the cookie" do
        before do
          set_cookie 'session_nonce=XYZ'
          get '/hi'
        end

        it "requires a new authentication" do
          assert_requires_authentication
        end
      end

      context "and visits the app with the same nonce in the cookie" do
        it "does not require a new authentication" do
          set_cookie 'session_nonce=ABC'
          get '/hi'
          assert_equal 'hi', last_response.body
        end
      end
    end
  end
end
