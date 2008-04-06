require File.dirname(__FILE__)+'/test_helper'

ActionMessager::Base.jabber_settings = {
  :username => 'james',
  :password => 'swordfish'
}

class MockNotifier < ActionMessager::Base
end

class ActionMessagerTest < Test::Unit::TestCase
  context "connection" do
    should "establish connection to Jabber::Simple using settings credentials" do
      Jabber::Simple.expects(:new).with('james', 'swordfish')
      ActionMessager::Base.connection
    end
    
    should "raise ArgumentError if there are no credentials" do
      ActionMessager::Base.jabber_settings = {
        :username => '',
        :password => ''
      }
      
      assert_raise(ArgumentError) do
        ActionMessager::Base.connection
      end
    end
  end
  
  context "delivering messages" do
    should "instantiate a new messager object" do
      MockNotifier.expects(:new).returns(stub(:changeset => '', :recipients => []))
      MockNotifier.deliver_changeset
    end
    
    should "call the changeset method on the new messager" do
      notifier_instance = mock(:changeset => '', :recipients => [])
      MockNotifier.stubs(:new).returns(notifier_instance)
      MockNotifier.deliver_changeset
    end
    
    should "deliver the return value of the method to each of the recipients" do
      @message = 'some message'
      connection = mock
      connection.expects(:deliver).with('james@giraffesoft.ca', 'some message')
      connection.expects(:deliver).with('tony@arktyp.ca', 'some message')
      MockNotifier.stubs(:connection).returns(connection)
      MockNotifier.any_instance.stubs(:changeset).returns(@message)
      MockNotifier.any_instance.stubs(:recipients).returns(%w(james@giraffesoft.ca tony@arktyp.ca))
      MockNotifier.deliver_changeset
    end
  end
end
