create or replace TABLE "company_master" (
    id INTEGER AUTOINCREMENT NOT NULL,
    org_id INTEGER NULL,
    transmission_id BIGINT NULL,
    payroll_company_id VARCHAR(42) DEFAULT NULL,
    name VARCHAR(255) DEFAULT NULL,
    legal_name VARCHAR(255) DEFAULT NULL,
    entity_type VARCHAR(25) DEFAULT NULL,
    tax_filing_status VARCHAR(25) DEFAULT NULL,
    fein VARCHAR(15) DEFAULT NULL,
    primary_contact_name VARCHAR(80) DEFAULT NULL,
    primary_contact_email VARCHAR(80) DEFAULT NULL,
    primary_phone VARCHAR(15) DEFAULT NULL,
    primary_address VARCHAR(30) DEFAULT NULL,
    primary_address2 VARCHAR(30) DEFAULT NULL,
    primary_city VARCHAR(30) DEFAULT NULL,
    primary_state VARCHAR(2) DEFAULT NULL,
    primary_postal_code VARCHAR(10) DEFAULT NULL,
    primary_county_code VARCHAR(25) DEFAULT NULL,
    country_code VARCHAR(5) DEFAULT NULL,
    naics_code VARCHAR(6) DEFAULT NULL,
    company_master_status_id INTEGER NULL,
    status VARCHAR(1) DEFAULT NULL,
    is_944 VARCHAR(1) DEFAULT NULL,
    plan_start_date DATE NULL,
    plan_end_date DATE NULL,
    last_paycheck_date DATE NULL,
    is_seasonal VARCHAR(1) DEFAULT NULL,
    is_501c3 VARCHAR(1) DEFAULT NULL,
    override_reason VARCHAR(255) DEFAULT NULL,
    company_logo_filename VARCHAR(100) DEFAULT NULL,
    created_at TIMESTAMP_NTZ NOT NULL,
    created_by INTEGER NULL,
    updated_at TIMESTAMP_NTZ NOT NULL,
    updated_by INTEGER NULL,
    company_start_date DATE NULL,
    company_end_date DATE NULL,
    pay_cycle VARCHAR(100) DEFAULT NULL,
    supplemental_data VARCHAR(500) NULL,
    CONSTRAINT company_master_pkey PRIMARY KEY (id)
) CLUSTER BY (fein, payroll_company_id, transmission_id);


insert into company_master (org_id, transmission_id, payroll_company_id, name, legal_name, entity_type, tax_filing_status, fein, primary_contact_name, primary_contact_email, primary_phone, primary_address, primary_address2, primary_city, primary_state, primary_postal_code, primary_county_code, country_code, naics_code, company_master_status_id, status, is_944, plan_start_date, plan_end_date, last_paycheck_date, is_seasonal, is_501c3, override_reason, company_logo_filename, pay_cycle, supplemental_data, created_at, created_by, updated_at, updated_by, company_start_date, company_end_date) values (1, 1, '1234567890', 'Test Company', 'Test Company', 'Corporation', 'Active', '1234567890', 'John Doe', 'john.doe@example.com', '1234567890', '123 Main St', 'Apt 1', 'Anytown', 'CA', '12345', '12345', 'US', '123456', 1, 'A', 'Y', '2021-01-01', '2021-01-01', '2021-01-01', 'N', 'N', 'Test Reason', 'test.jpg', 'Monthly', 'Test Supplemental Data', '2021-01-01', 1, '2021-01-01', 1, '2021-01-01', '2021-01-01');

insert into company_master (org_id, transmission_id, payroll_company_id, name, legal_name, entity_type, tax_filing_status, fein, primary_contact_name, primary_contact_email, primary_phone, primary_address, primary_address2, primary_city, primary_state, primary_postal_code, primary_county_code, country_code, naics_code, company_master_status_id, status, is_944, plan_start_date, plan_end_date, last_paycheck_date, is_seasonal, is_501c3, override_reason, company_logo_filename, pay_cycle, supplemental_data, created_at, created_by, updated_at, updated_by, company_start_date, company_end_date) values (2, 2, '2345678901', 'Alpha Industries', 'Alpha Industries LLP', 'LLC', 'Inactive', '2345678901', 'Alice Smith', 'alice.smith@alpha.com', '234-567-8901', '234 Alpha Rd', 'Suite 201', 'Alpha City', 'NY', '10001', '10001', 'US', '234561', 2, 'I', 'N', '2022-02-01', '2023-02-01', null, 'Y', 'Y', 'Inactive in 2023', 'alpha_logo.png', 'Biweekly', null, '2022-02-01', 2, '2023-03-01', 2, '2022-02-01', null);

insert into company_master (org_id, transmission_id, payroll_company_id, name, legal_name, entity_type, tax_filing_status, fein, primary_contact_name, primary_contact_email, primary_phone, primary_address, primary_address2, primary_city, primary_state, primary_postal_code, primary_county_code, country_code, naics_code, company_master_status_id, status, is_944, plan_start_date, plan_end_date, last_paycheck_date, is_seasonal, is_501c3, override_reason, company_logo_filename, pay_cycle, supplemental_data, created_at, created_by, updated_at, updated_by, company_start_date, company_end_date) values (3, 3, '3456789012', 'Beta Solutions', 'Beta Solutions Inc', 'SoleProp', 'Pending', '3456789012', 'Bob Brown', 'bob.brown@beta.com', '345-678-9012', '345 Beta Ave', null, 'Beta Town', 'TX', '75001', '75001', 'US', '345612', 3, 'P', 'N', '2022-07-11', '2023-07-11', '2023-09-01', 'N', 'N', 'Pending tax records', 'beta_logo.jpg', 'Weekly', 'On probation', '2022-07-11', 3, '2023-07-12', 3, '2022-07-11', '2023-07-11');

insert into company_master (org_id, transmission_id, payroll_company_id, name, legal_name, entity_type, tax_filing_status, fein, primary_contact_name, primary_contact_email, primary_phone, primary_address, primary_address2, primary_city, primary_state, primary_postal_code, primary_county_code, country_code, naics_code, company_master_status_id, status, is_944, plan_start_date, plan_end_date, last_paycheck_date, is_seasonal, is_501c3, override_reason, company_logo_filename, pay_cycle, supplemental_data, created_at, created_by, updated_at, updated_by, company_start_date, company_end_date) values (4, 4, '4567890123', 'Gamma Group', 'Gamma Group PC', 'Partnership', 'Active', '4567890123', 'Clara Green', 'clara.green@gamma.com', '456-789-0123', '456 Gamma Blvd', '', 'Gamma City', 'FL', '33101', '33101', 'US', '456123', 4, 'A', 'Y', '2022-09-09', '2024-09-09', null, 'Y', 'N', null, null, 'Monthly', null, '2022-09-09', 4, '2023-04-10', 4, '2022-09-09', '2024-09-09');

insert into company_master (org_id, transmission_id, payroll_company_id, name, legal_name, entity_type, tax_filing_status, fein, primary_contact_name, primary_contact_email, primary_phone, primary_address, primary_address2, primary_city, primary_state, primary_postal_code, primary_county_code, country_code, naics_code, company_master_status_id, status, is_944, plan_start_date, plan_end_date, last_paycheck_date, is_seasonal, is_501c3, override_reason, company_logo_filename, pay_cycle, supplemental_data, created_at, created_by, updated_at, updated_by, company_start_date, company_end_date) values (5, 5, '5678901234', 'Delta Works', 'Delta & Works Incorporated', 'Nonprofit', 'Active', '5678901234', 'Dan Red', 'dan.red@deltaworks.org', '567-890-1234', '567 Delta Way', 'Bldg B', 'Delta City', 'IL', '60601', '60601', 'US', '567134', 5, 'A', 'N', '2021-06-15', '2023-06-15', null, 'N', 'Y', 'Charity status', 'delta_logo.gif', 'Semi-monthly', 'Special case', '2021-06-15', 5, '2023-06-16', 5, '2021-06-15', '2023-06-15');

insert into company_master (org_id, transmission_id, payroll_company_id, name, legal_name, entity_type, tax_filing_status, fein, primary_contact_name, primary_contact_email, primary_phone, primary_address, primary_address2, primary_city, primary_state, primary_postal_code, primary_county_code, country_code, naics_code, company_master_status_id, status, is_944, plan_start_date, plan_end_date, last_paycheck_date, is_seasonal, is_501c3, override_reason, company_logo_filename, pay_cycle, supplemental_data, created_at, created_by, updated_at, updated_by, company_start_date, company_end_date) values (6, 6, '6789012345', 'Omega Enterprises', 'Omega Enterprises Ltd.', 'Corporation', 'Inactive', '6789012345', 'Eve White', 'eve.white@omega.com', '678-901-2345', '678 Omega Square', null, 'Omega City', 'WA', '98001', '98001', 'US', '678145', 6, 'I', 'Y', '2020-10-20', null, null, 'Y', 'N', 'Business closed', 'omega_logo.svg', 'Monthly', null, '2020-10-20', 6, '2021-01-20', 6, '2020-10-20', null);
