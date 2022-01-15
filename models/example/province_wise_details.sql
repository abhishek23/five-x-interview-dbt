
/*
    Welcome to your first dbt model!
    Did you know that you can also configure models directly within SQL files?
    This will override configurations stated in dbt_project.yml

    Try changing "table" to "view" below
*/

{{ config(materialized='table') }}

with source_data as (
    SELECT 
        location as province_name,
        population,
        population_density,
        total_recovered,
        total_active_cases,
        total_deaths,
        total_cases,
        total_deaths_per_million,
        area_km_2_ as area_km_2
    from "FIVETRAN_INTERVIEW_DB"."GOOGLE_SHEETS"."COVID_19_INDONESIA_ABHISHEK_DALVI"
    where location_level = 'Province'
    QUALIFY ROW_NUMBER() OVER (PARTITION BY location ORDER BY date DESC) = 1 
)
select *
from source_data;

