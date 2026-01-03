# Local Bikes Retail Case Study
Production Grade, End-to-End Analytics Engineering Project with Airbyte & BigQuery & dbt & GitHub Actions

Owner: Mert Demirel


## Security & Credentials
This repository does **not** contain any credentials, secrets, or service
account keys.
All warehouse connections, environments, and executions are managed securely
via **dbt Cloud**.

Running this project requires:
- A dbt Cloud account
- A BigQuery project
- Proper credentials configured by the user

## Documentation
This project is fully documented using:
Model descriptions
Column descriptions
Business logic explanations

To generate docs locally or in dbt Cloud:

- dbt docs generate
- dbt docs serve

**Auto-generated YAML**

Schema files are generated using dbt-codegen:

- dbt run-operation generate_model_yaml --args '{ "model_names": [...] }'

Lineage of the project

<img width="1734" height="820" alt="Screenshot 2026-01-03 at 1 58 51 pm" src="https://github.com/user-attachments/assets/f953fa12-2bef-453c-9dea-75499146248b" />

## Business Intelligence / Restitution of Data

For a quick representation of data as a dashboard, **Looker Studio** is used.

https://lookerstudio.google.com/reporting/7a701296-b28c-4fc4-bfd8-a23e3af5c762

The marts produced by this project feed Looker Studio dashboards designed for business users.

<img width="1444" height="760" alt="Screenshot 2025-12-30 at 10 32 43 am" src="https://github.com/user-attachments/assets/7ba8a793-be30-49a9-a82a-396b3304368d" />

<img width="1443" height="763" alt="Screenshot 2025-12-30 at 10 32 52 am" src="https://github.com/user-attachments/assets/678146da-d7ff-468a-82fd-ff01483b1c01" />

<img width="1158" height="646" alt="Screenshot 2025-12-30 at 10 33 00 am" src="https://github.com/user-attachments/assets/357347eb-cf4e-45f2-b4aa-add23a5e14ff" />

## CI / Deployment

dbt Cloud is used for orchestration
Models are built automatically on merge to main
CI Job tests run before production deployment
Documentation is refreshed after successful builds
