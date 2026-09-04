# API.Part1
RaceDay is a race/event management system. Organisers create events with one or more categories (e.g. 5km, 10km), participants register for a category, and results are captured once the race is complete.

Single users table with role-based access, instead of separate Organiser/Participant tables. An earlier draft of the ERD modelled Organiser and Participant as two separate entities. The final design merges them into one users table and adds a Roles lookup table (Organiser, Participant), linked by role_id. This was a deliberate change, not an oversight:

It satisfies the brief's requirement to demonstrate role-based system design before writing any application code — role checks in the Part 2 API will be driven by this role_id/Roles relationship.
It avoids duplicating shared fields (name, email, password, contact number) across two tables.
Adding a new role later (e.g. an Admin role) only requires a new row in Roles, not a schema change.

EventRegistrations has a status column with a CHECK constraint. Not shown in the original brief's example table, but added so an enrolment can be tracked through Pending → Confirmed → Cancelled, which the API endpoint plan (enrolment/cancellation endpoints) depends on.

results.finishTime uses the TIME type, results.status uses a CHECK constraint (Finished, DNF, DQ). Chosen over storing finish time as free text so results can be sorted and compared directly in SQL for ranking.

The SQL script in RaceDay_Schema.sql matches RaceDay_ERD.png exactly — same tables, same columns, same primary/foreign keys, same cardinality. There are no unexplained differences between the two.
