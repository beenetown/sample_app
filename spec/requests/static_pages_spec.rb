require 'spec_helper'

describe "Static pages" do
  let(:base_title) { "Ruby on Rails Tutorial Sample App" }

  subject { page }

  shared_examples_for "all static pages" do
    it { should have_selector('h1', text: heading) }
    it { should have_title(full_title(page_title)) }
  end

  describe "Home page" do
    before { visit root_path }  
    let(:heading)    { 'Sample App' }
    let(:page_title) { "" }

    it_should_behave_like "all static pages" 
    it { should_not have_title("| Home") }    

    describe "for signed-in users" do
      let(:user) { FactoryGirl.create(:user) }
      before do
        FactoryGirl.create(:micropost, user: user, content: "Lorem ipsum")
        FactoryGirl.create(:micropost, user: user, content: "Dolor sit amet")
        sign_in user
        visit root_path
      end

      it "should render the user's feed" do
        user.feed.each do |item|
          expect(page).to have_selector("li##{item.id}", text: item.content)
        end
      end

      describe "should not have delete links for other users' posts" do
        let(:other_user) { FactoryGirl.create(:user) }
        before do
          FactoryGirl.create(:micropost, user: other_user) 
          visit user_path(other_user)
        end

        it { should_not have_link('delete') }
      end

      it "should have a sidebar micropost count with proper pluralization" do
        expect(page).to have_content('2 microposts') 
        click_link "delete", match: :first 
        expect(page).to have_content('1 micropost') 
      end

      describe "should have a micropost feed with pagination" do
        before do 
          31.times { FactoryGirl.create(:micropost, user: user) } 
          visit root_path
        end
        after(:all) { Micropost.delete_all }

        it { should have_selector('div.pagination') }
      end
    end
  end

  describe "Help page" do
    before { visit help_path }
    let(:heading)    { "Help" }
    let(:page_title) { "Help" }

    it_should_behave_like "all static pages"
  end

  describe "About page" do
    before { visit about_path }
    let(:heading)    { "About us" }
    let(:page_title) { "About" }

    it_should_behave_like "all static pages"
  end

  describe "Contact Page" do
    before { visit contact_path }
    let(:heading)    { "Contact Us" }
    let(:page_title) { "Contact" }

    it_should_behave_like "all static pages"
  end

  it "should have the right links on the layout" do
    visit root_path
    # Test about link
    click_link "About"
    expect(page).to have_title(full_title("About Us"))
    # Test help link
    click_link "Help"
    expect(page).to have_title(full_title('Help'))
    # Test contact link
    click_link "Contact"
    expect(page).to have_title(full_title("Contact Us"))
    # Test sign up now link on homepage
    click_link "Home"
    click_link "Sign up now!"
    expect(page).to have_title(full_title("Sign up"))
    # Test logo "sample app" link
    click_link "sample app"
    expect(page).to have_title(full_title(""))
  end
end