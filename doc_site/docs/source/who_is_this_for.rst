Who Is This For
=====


This is for you if:
----------------

You're looking for a way to be able to spin up a data stack that's secure, compliant, and you just paying for the compute costs. Either you, or someone in your company has access to a cloud environment, and are comfortable running a `terraform apply` command, or are willing to learn to save hundreds of thousands of dollars in the long term.


.. _pain:
The Pain
----------------


"Can we just see this as a dashboard?"

The question will inevitable come at any company, and there's a huge barrier of entry to be able to say "yes," especially in a way that satisfies security, compliance, and SLAs. 

At a previous startup, we were at a growth point where throwing up an Apache Superset dashboard pointed at a database would have been a huge win. 

After a series of tradeoffs discussions, we ended up throwing a dockerized deployment on a dedicated EC2 instance in our VPN. Users had to access it via a IP adress on a random port, full of SSL warnings of an unverified certificate. It worked, and was secure, but was a bad user experience, didn't scale, had no database backups, and was a ticking timebomb. 

Not long after, we signed a mid five figures deal with a BI vendor to have a cloud deployment that checked all our boxes. The overhead to get a deployment that checked all the boxes was enough effort, a large vendor spend made more sense.

Later, as I've run a data services company helping companies stand up data stacks, the pattern repeats. Not just with dashboards, but with ETL, warehouses, storage, etc. There are amazing open source projects that serve the needs of small to mid size businesses, but actually operationalizing these projects requires a huge amount of domain knowledge. 




.. code-block:: console

   $ gh repo fork kadreio/relativistic

