# After `the colonist bar is hidden` and `the learning helper is hidden`, neither the colonist bar nor the learning helper list may be drawn,
# even after the camera moves (it activates concepts such as "Camera dolly"). The bar redraws from a cache that has to be marked dirty;
# the helper shows itself while any concept is active, so new ones must be blocked.
@requires:nelim.pickletools.screenshotstudio
Feature: Sanctuary: colonist bar and learning helper hidden

  Scenario: bar-and-helper-hidden: neither is drawn
    Given the save "Nelims-tribe" is loaded
    And game speed is paused
    And Nelim's Pickle Tools: the colonist bar is hidden
    And Nelim's Pickle Tools: the learning helper is hidden
    And Nelim's Sanctuary: I am at the sanctuary "sleeping-nook"
    And Nelim's Pickle Tools: the camera root size is set to 6
    And I take a screenshot "bar-and-helper-hidden"
