    create or replace TABLE survey_question (
        id INTEGER AUTOINCREMENT NOT NULL,
        survey_id INTEGER NOT NULL,
        question_text VARCHAR(1000) NOT NULL,
        question_type VARCHAR(50) NOT NULL,
        is_required BOOLEAN DEFAULT FALSE,
        sort_order INTEGER DEFAULT 0,
        options VARCHAR(2000) DEFAULT NULL,
        created_at TIMESTAMP_NTZ NOT NULL DEFAULT current_timestamp(),
        created_by INTEGER NULL,
        CONSTRAINT survey_question_pkey PRIMARY KEY (id)
    );


insert into survey_question (survey_id, question_text, question_type, is_required, sort_order, options, created_at, created_by)
values
(1, 'What is the primary purpose of a balance sheet?', 'single_choice', TRUE, 1, '["To show a company''s assets, liabilities, and equity","To show annual revenue only","To show employee performance","To forecast market trends"]', current_timestamp(), 1),
(1, 'Which of the following is considered a liability?', 'single_choice', TRUE, 2, '["Bank loans","Cash in hand","Inventory","Accounts receivable"]', current_timestamp(), 1),
(1, 'What is meant by diversification in investing?', 'single_choice', TRUE, 3, '["Spreading investments across different assets","Investing all funds in a single stock","Buying only government bonds","Speculating on derivatives"]', current_timestamp(), 1),
(1, 'Interest earned on both the initial principal and the accumulated interest from previous periods is called:', 'single_choice', TRUE, 4, '["Compound interest","Simple interest","Nominal interest","Flat interest"]', current_timestamp(), 1),
(1, 'Which of the following is a fixed cost for a business?', 'single_choice', FALSE, 5, '["Office rent","Raw material cost","Direct labor","Sales commissions"]', current_timestamp(), 1),
(1, 'In which financial statement would you typically find ''Net Income'' reported?', 'single_choice', TRUE, 6, '["Income Statement","Balance Sheet","Cash Flow Statement","Statement of Changes in Equity"]', current_timestamp(), 1),
(1, 'Which of the following is an example of an asset?', 'single_choice', TRUE, 7, '["Accounts receivable","Long-term loan","Accrued expense","Deferred revenue"]', current_timestamp(), 1),
(1, 'Select all common types of financial derivatives:', 'multiple_choice', FALSE, 8, '["Futures","Options","Swaps","Mortgages"]', current_timestamp(), 1),
(1, 'What does the term ''liquidity'' refer to in finance?', 'text', TRUE, 9, null, current_timestamp(), 1),
(1, 'True or False: Stocks generally carry higher risk than government bonds.', 'single_choice', FALSE, 10, '["True","False"]', current_timestamp(), 1),
(1, 'Please explain the difference between revenue and profit.', 'text', FALSE, 11, null, current_timestamp(), 1),
(1, 'Match the following: GDP relates to (A) Country''s economic output; EPS relates to (B) Company''s share profitability.', 'single_choice', FALSE, 12, '["A-GDP, B-EPS","A-EPS, B-GDP"]', current_timestamp(), 1),
(1, 'Which items might appear in the operating activities section of a cash flow statement?', 'multiple_choice', TRUE, 13, '["Cash received from customers","Payment to suppliers","Issuing shares","Purchasing equipment"]', current_timestamp(), 1),
(1, 'What does ROI stand for in the context of finance?', 'single_choice', TRUE, 14, '["Return on Investment","Rate of Income","Revenue on Interest","Return on Inventory"]', current_timestamp(), 1),
(1, 'List two main functions of central banks.', 'text', FALSE, 15, null, current_timestamp(), 1);

