# Apex Time Mocks

Mock times in your Apex code. By using the `Clock` class, you can set specific times for testing purposes, ensuring consistent and reliable test results.

## Usage

1. **Set a Mock Time**: Use the `Clock.setMockTimeCall(Datetime dt)` method to set a specific time.
2. **Get the Current Time**: Call `Clock.now()` to get the current time. If a mock time is set, it will return the mocked time.
3. **Get the Current Time in Milliseconds**: Call `Clock.currentTimeMillis()` to get the current time in milliseconds. If a mock time is set, it will return the mocked time in milliseconds.
4. **Get Today's Date**: Call `Clock.today()` to get today's date. If a mock time is set, it will return the mocked date.

## Example

```apex
@IsTest
private class ClockTest {
    @IsTest
    static void testSystemNow() {
        System.runAs(new User(Id = UserInfo.getUserId())) {
            // Test data setup
            Datetime now = System.now();
            Clock.setMockTimeCall(now.addDays(-5));

            // Actual test
            Test.startTest();
            Datetime mockedNow = Clock.now();
            Datetime realTimeNow = Clock.now(); // This should return the real current time after the mock is exhausted
            Test.stopTest();

            // Asserts
            Assert.areEqual(
                mockedNow,
                now.addDays(-5),
                'The mocked time should be 5 days ago.'
            );
            Assert.areEqual(
                realTimeNow,
                now,
                'The real time should be the current time.'
            );
        }
    }
}
```
