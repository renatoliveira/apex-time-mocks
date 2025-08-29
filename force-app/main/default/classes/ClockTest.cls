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
            Datetime mockedNow = Clock.systemNow();
            Datetime realTimeNow = Clock.systemNow(); // This should return the real current time after the mock is exhausted
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

    @IsTest
    static void testSystemCurrentTimeMillis() {
        System.runAs(new User(Id = UserInfo.getUserId())) {
            // Test data setup
            Long nowMillis = System.currentTimeMillis();
            Clock.setMockTimeCall(System.now().addDays(-5));

            // Actual test
            Test.startTest();
            Long mockedMillis = Clock.currentTimeMillis();
            Long realMillis = Clock.currentTimeMillis(); // This should return the real current time after the mock is exhausted
            Test.stopTest();

            // Asserts
            // divide by 1000 because there will be some milliseconds
            // difference between the two calls for sure
            Assert.areEqual(
                (mockedMillis / 1000),
                (System.now().addDays(-5).getTime() / 1000),
                'The mocked time should be 5 days ago in milliseconds.'
            );
            Assert.areEqual(
                (realMillis / 1000),
                (nowMillis / 1000),
                'The real time should be the current time in milliseconds.'
            );
        }
    }

    @IsTest
    static void testSystemToday() {
        System.runAs(new User(Id = UserInfo.getUserId())) {
            // Test data setup
            Date today = System.today();
            Clock.setMockTimeCall(System.now().addDays(-5));

            // Actual test
            Test.startTest();
            Date mockedToday = Clock.today();
            Date realToday = Clock.today(); // This should return the real current time after the mock is exhausted
            Test.stopTest();

            // Asserts
            Assert.areEqual(
                mockedToday,
                today.addDays(-5),
                'The mocked time should be 5 days ago.'
            );
            Assert.areEqual(
                realToday,
                today,
                'The real time should be the current time.'
            );
        }
    }

    @IsTest
    static void testDatetimeNow() {
        System.runAs(new User(Id = UserInfo.getUserId())) {
            // Test data setup
            Datetime now = System.now();
            Clock.setMockTimeCall(now.addDays(-5));

            // Actual test
            Test.startTest();
            Datetime mockedNow = Clock.gmtNow();
            Datetime realTimeNow = Clock.gmtNow(); // This should return the real current time after the mock is exhausted
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
