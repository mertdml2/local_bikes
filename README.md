Mert x Databird final project documentation of Local Bikes

This project is fully documented using:
Model descriptions
Column descriptions
Business logic explanations

To generate docs locally or in dbt Cloud:
dbt docs generate
dbt docs serve

Auto-generated YAML
Schema files are generated using dbt-codegen:
dbt run-operation generate_model_yaml --args '{ "model_names": [...] }'

📈 Looker Studio Dashboards
https://lookerstudio.google.com/reporting/7a701296-b28c-4fc4-bfd8-a23e3af5c762

The marts produced by this project feed Looker Studio dashboards designed for business users.

<img width="1444" height="760" alt="Screenshot 2025-12-30 at 10 32 43 am" src="https://github.com/user-attachments/assets/7ba8a793-be30-49a9-a82a-396b3304368d" />

<img width="1443" height="763" alt="Screenshot 2025-12-30 at 10 32 52 am" src="https://github.com/user-attachments/assets/678146da-d7ff-468a-82fd-ff01483b1c01" />

<img width="1158" height="646" alt="Screenshot 2025-12-30 at 10 33 00 am" src="https://github.com/user-attachments/assets/357347eb-cf4e-45f2-b4aa-add23a5e14ff" />

CI / Deployment

dbt Cloud is used for orchestration
Models are built automatically on merge to main
Tests run before production deployment
Documentation is refreshed after successful builds



Authors & Ownership
Mert Demirel
