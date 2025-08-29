/**
 * @description mock time calls during tests.
 */
public class Clock {
    private static List<Datetime> mockedTimes = new List<Datetime>();
    private static Integer timesCalled = 0;

    /**
     * @description Helper to get mocked Datetime if in test context.
     * @param defaultValue The default value to return if not mocked.
     * @param t The type of value to return: 'datetime', 'millis', or 'date'.
     * @return Object The mocked or default value.
     */
    private static Object getMockedOrDefault(Object defaultValue, Type t) {
        if (Test.isRunningTest() && !mockedTimes.isEmpty()) {
            timesCalled += 1;
            if (timesCalled > mockedTimes.size()) {
                return defaultValue;
            }
            Datetime dt = mockedTimes[timesCalled - 1];
            if (t == Datetime.class) {
                return dt;
            } else if (t == Long.class) {
                return dt.getTime();
            } else if (t == Date.class) {
                return dt.date();
            }
        }
        return defaultValue;
    }

    /**
     * @description Get the current time.
     * @return Datetime The current time.
     */
    public static Datetime now() {
        return (Datetime) getMockedOrDefault(System.now(), Datetime.class);
    }

    /**
     * @description Get the current time in milliseconds since epoch.
     * @return Long The current time in milliseconds.
     */
    public static Long currentTimeMillis() {
        return (Long) getMockedOrDefault(
            System.currentTimeMillis(),
            Long.class
        );
    }

    /**
     * @description Get today's date.
     * @return Date Today's date.
     */
    public static Date today() {
        return (Date) getMockedOrDefault(System.today(), Date.class);
    }

    /**
     * @description sets a mocked time call.
     * @param dt The mocked Datetime to set.
     */
    @TestVisible
    private static void setMockTimeCall(Datetime dt) {
        mockedTimes.add(dt);
    }
}
