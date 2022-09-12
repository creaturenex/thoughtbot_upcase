# Tests can tell a story

Tests have "phases"

- Setup
  - Get the conditions correct for the test
- Exercise
- Verification
- Teardown

## Example of Test Phase in Action

```ruby
describe "#promote_to_admin" do
  it "makes a regular membership an admin membership" do
    # setup
    membership = Membership.new(admin: false)

    # exercise
    membership.promote_to_admin

    # verify
    expect(membership).to be_admin
  end
end
```

## Example of a Not so Good Story

```ruby
  describe Membership do
  before(:each) do
    chocolate_membership.promote_to_admin
  end

  let(:user) { User.new("Bill Wonka") }
  let(:chocolate_group) { Group.new("Chocolate Factory") }
  let(:peach_group) { Group.new("Giant Peach Enthusiasts") }
  let(:chocolate_membership) { Membership.new(user: user, group: chocolate_group, admin: false) }
  let(:peach_membership) { Membership.new(user: user, group: peach_group, admin: false) }

  describe "#promote_to_admin" do
    it "makes a regular membership an admin membership" do
      expect(chocolate_membership).to be_admin
    end

    it "doesn't change other memberships" do
      expect(peach_membership).not_to be_admin
    end
  end
end
```

This not a goos example because it is hard to see the "story" in the code.

Why? The programmer is using before and let syntax to "Setup" the conditions for testing, but this makes it hard to follow the test in the describe block. For example it to read the before block, then the let block and back to the test.

By Inlining fixtures, removing unrelated data and defining a setup method within your describe block will make it much easier for your code to be read.
