-- Function: mark_reservations_expired()

-- DROP FUNCTION mark_reservations_expired();

CREATE OR REPLACE FUNCTION mark_reservations_expired()
  RETURNS void AS
$BODY$
BEGIN

UPDATE reservations
SET state = 'Expired'
WHERE created_at < current_date - interval '30' day;

END;
$BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;
ALTER FUNCTION mark_reservations_expired()
  OWNER TO postgres;
