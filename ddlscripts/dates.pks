CREATE OR REPLACE PACKAGE BEMCSMGR.dates
IS
   /* Jill Stanton 28-sep-2007 Added function for mcs transfer to 11.5.10
   || 1.1        25/01/2016   S Gibby           EU HD 114528 - added is_Sunday_date ans is_Saturday_date functions as part of MEG MCS migration
   || 1.2        07/06/2017   T Webb            114655 - Added period_open overloads.
   || 1.3        03/09/2018   S Gibby           114744 NZ to Rest of the World Merge
   */
   -- Function to indicate whether a given year_no exists in fisc_per
   FUNCTION year_exists   (p_year_no     IN NUMBER)
   RETURN BOOLEAN;

   -- Function to indicate whether a given period_no exists in fisc_per.
   FUNCTION period_exists (p_period_no   IN NUMBER,
                           p_year_no     IN NUMBER,
                           p_int_type    IN VARCHAR2 DEFAULT 'MO')
   RETURN BOOLEAN;

   -- Function to indicate whether a given period exists, based on dates.
   FUNCTION period_exists (p_int_type    IN VARCHAR2,
			   p_start_date  IN DATE,
			   p_end_date    IN DATE)
   RETURN BOOLEAN;
   
   FUNCTION period_exists (p_start_date  IN DATE,
                  p_int_type    IN VARCHAR2 DEFAULT 'MO')
   RETURN BOOLEAN;

   -- Function to check if a given period has been closed in fisc_per.
   FUNCTION period_closed (p_period_no   IN NUMBER,
                           p_year_no     IN NUMBER,
                           p_int_type    IN VARCHAR2 DEFAULT 'MO')
   RETURN BOOLEAN;

   -- Function to check if a given period has been closed in fisc_per.
   FUNCTION period_closed (p_date        IN DATE,
                           p_int_type    IN VARCHAR2 DEFAULT 'MO')
   RETURN BOOLEAN;

   -- Function to check if a given period has been closed in fisc_per.
   FUNCTION period_suspended (p_period_no   IN NUMBER,
                              p_year_no     IN NUMBER,
                              p_int_type    IN VARCHAR2 DEFAULT 'MO')
   RETURN BOOLEAN;
   
   FUNCTION period_suspended (p_date        IN DATE,
                              p_int_type    IN VARCHAR2 DEFAULT 'MO')
   RETURN BOOLEAN;

   -- Overloaded procedure to return start and end dates for a period.
   PROCEDURE get_date_range (p_per_no       IN  NUMBER,
                             p_year_no      IN  NUMBER,
                             p_per_int_type IN  VARCHAR2,
                             p_start_date   OUT DATE,
                             p_end_date     OUT DATE);

   -- Second overloaded version of get_date_range, this version gets the range for multiple periods.
   PROCEDURE get_date_range (p_per_no_from      IN  NUMBER,
                             p_per_no_to        IN  NUMBER,
                             p_per_year_no_from IN  NUMBER,
                             p_per_year_no_to   IN  NUMBER,
                             p_per_int_type     IN  VARCHAR2,
                             p_start_date       OUT DATE,
                             p_end_date         OUT DATE);

   --Function takes in date values in VARCHAR2 format, checks that they
   --are valid, and then that the start date is less than end date.
   --Returns:
   --	0	OK
   --   1	Dates not in correct format
   --   2	Start date greater than end date

   FUNCTION validate_start_end_dates(p_start_date IN VARCHAR2,
				     p_end_date   IN VARCHAR2,
				     p_date_mask  IN VARCHAR2)
   RETURN NUMBER;

-- Added by Jill Stanton 28-sep-2007
   FUNCTION period_start_date (p_period_no   IN NUMBER,
                               p_year_no     IN NUMBER,
                               p_int_type    IN VARCHAR2 DEFAULT 'MO')
   RETURN DATE;
   PRAGMA RESTRICT_REFERENCES (period_start_date,   WNDS);
    -- Function to return only the end date of a given period.
   FUNCTION period_end_date (p_period_no   IN NUMBER,
                             p_year_no     IN NUMBER,
                             p_int_type    IN VARCHAR2 DEFAULT 'MO')
   RETURN DATE;

   -- Return the year + week codes for a given date, plus current status.
   PROCEDURE get_date_periods (p_date_in IN DATE,
                               p_period_out OUT NUMBER,
                               p_year_out OUT NUMBER,
                               p_status_out OUT fisc_per.per_osc_flag%TYPE,
                               p_start_date_out OUT DATE,
                               p_end_date_out OUT DATE);

   FUNCTION is_sunday_date (p_date IN DATE)
   RETURN BOOLEAN;

   FUNCTION is_saturday_date (p_date IN DATE)
   RETURN BOOLEAN;

   /* Is-this-period-open? Functions. */
   FUNCTION period_open(p_period_no IN NUMBER,
                        p_year_no IN NUMBER,
                        p_int_type IN VARCHAR2 DEFAULT 'MO'
                       )
   RETURN BOOLEAN;

   FUNCTION period_open(p_date IN DATE,
                        p_int_type IN VARCHAR2 DEFAULT 'MO'
                       )
   RETURN BOOLEAN;
   
   FUNCTION gibby (p_date IN DATE,
                        p_int_type IN VARCHAR2 DEFAULT 'MO'
                       )
   RETURN BOOLEAN;

END dates;
/