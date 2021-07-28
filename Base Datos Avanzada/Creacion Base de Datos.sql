CREATE TABLE casos_confirmados (
    date                            VARCHAR(15) NOT NULL,
    total_cases                     DOUBLE NOT NULL,
    new_cases                       DOUBLE NOT NULL,
    new_cases_smoothed              DOUBLE NOT NULL,
    total_cases_per_million         DOUBLE NOT NULL,
    new_cases_per_million           DOUBLE NOT NULL,
    new_cases_smoothed_per_million  DOUBLE NOT NULL,
    reproduction_rate               DOUBLE NOT NULL,
    iso_code                        VARCHAR(3) NOT NULL
);

ALTER TABLE casos_confirmados ADD CONSTRAINT casos_confirmados_pk PRIMARY KEY ( date, iso_code );

CREATE TABLE hospitalizaciones (
    date                                VARCHAR(15) NOT NULL,
    icu_patients                        DOUBLE NOT NULL,
    icu_patients_per_million            DOUBLE NOT NULL,
    hosp_patients                       DOUBLE NOT NULL,
    hosp_patients_per_million           DOUBLE NOT NULL,
    hosp_patients_per_million_1         DOUBLE NOT NULL, 
    weekly_icu_admissions_per_million   DOUBLE NOT NULL,
    weekly_hosp_admissions              DOUBLE NOT NULL, 
    weekly_hosp_admissions_per_million  DOUBLE NOT NULL,
    iso_code                            VARCHAR(3) NOT NULL
);

ALTER TABLE hospitalizaciones ADD CONSTRAINT hospitalizaciones_pk PRIMARY KEY ( date,
                                                                                iso_code );

CREATE TABLE muertes_covid (
    date                             VARCHAR(15) NOT NULL,
    total_deaths                     DOUBLE NOT NULL,
    new_deaths                       DOUBLE NOT NULL,
    new_deaths_smoothed              DOUBLE NOT NULL,
    total_deaths_per_million         DOUBLE NOT NULL,
    new_deaths_per_million           DOUBLE NOT NULL, 
    new_deaths_smoothed_per_million  DOUBLE NOT NULL,
    iso_code                         VARCHAR(3) NOT NULL
);

ALTER TABLE muertes_covid ADD CONSTRAINT muertes_covid_pk PRIMARY KEY ( date,
                                                                        iso_code );

CREATE TABLE pais_variantes (
    iso_code1  VARCHAR(3) NOT NULL,
    country    VARCHAR(25) NOT NULL
);

ALTER TABLE pais_variantes ADD CONSTRAINT variantes_pkv1 PRIMARY KEY ( iso_code1 );

CREATE TABLE pruebas (
    date                             VARCHAR(15) NOT NULL,
    new_tests                        DOUBLE NOT NULL,
    total_tests                      DOUBLE NOT NULL,
    total_tests_per_thousand         DOUBLE NOT NULL,
    new_tests_per_thousand           DOUBLE NOT NULL,
    new_tests_smoothed               DOUBLE NOT NULL, 
    new_tests_smoothed_per_thousand  DOUBLE NOT NULL,
    positive_rate                    DOUBLE NOT NULL,
    tests_per_case                   DOUBLE NOT NULL,
    tests_units                      DOUBLE NOT NULL,
    iso_code                         VARCHAR(3) NOT NULL
);

ALTER TABLE pruebas ADD CONSTRAINT pruebas_pk PRIMARY KEY ( date,
                                                            iso_code );

CREATE TABLE reportecovid (
    iso_code   VARCHAR(3) NOT NULL,
    continent  VARCHAR(35) NOT NULL,
    location   VARCHAR(40) NOT NULL
);

ALTER TABLE reportecovid ADD CONSTRAINT reportecovid_pk PRIMARY KEY ( iso_code );

CREATE TABLE vacunados (
    date                                   VARCHAR(15) NOT NULL,
    total_vaccinations                     DOUBLE NOT NULL,
    people_vaccinated                      DOUBLE NOT NULL,
    people_fully_vaccinated                DOUBLE NOT NULL,
    new_vaccinations                       DOUBLE NOT NULL,
    new_vaccinations_smoothed              DOUBLE NOT NULL,
    total_vaccinations_per_hundred         DOUBLE NOT NULL,
    people_vaccinated_per_hundred          DOUBLE NOT NULL, 
    people_fully_vaccinated_per_hundred    DOUBLE NOT NULL, 
    new_vaccinations_smoothed_per_million  DOUBLE NOT NULL,
    iso_code                               VARCHAR(3) NOT NULL
);

ALTER TABLE vacunados ADD CONSTRAINT vacunados_pk PRIMARY KEY ( date,
                                                                iso_code );

CREATE TABLE variable_socioeconomicas (
    date                        VARCHAR(15) NOT NULL,
    stringency_index            DOUBLE NOT NULL,
    population                  DOUBLE NOT NULL,
    population_density          DOUBLE NOT NULL,
    median_age                  DOUBLE NOT NULL,
    aged_65_older               DOUBLE NOT NULL,
    aged_70_older               DOUBLE NOT NULL,
    gdp_per_capita              DOUBLE NOT NULL,
    extreme_poverty             DOUBLE NOT NULL,
    cardiovasc_death_rate       DOUBLE NOT NULL,
    diabetes_prevalence         DOUBLE NOT NULL,
    female_smokers              DOUBLE NOT NULL,
    male_smokers                DOUBLE NOT NULL,
    handwashing_facilities      DOUBLE NOT NULL,
    hospital_beds_per_thousand  DOUBLE NOT NULL,
    life_expectancy             DOUBLE NOT NULL,
    human_development_index     DOUBLE NOT NULL,
    iso_code                    VARCHAR(3) NOT NULL
);

ALTER TABLE variable_socioeconomicas ADD CONSTRAINT variable_socioeconomicas_pk PRIMARY KEY ( date,
                                                                                              iso_code );

CREATE TABLE variantes (
    iso_code                      VARCHAR(3) NOT NULL,
    year_week                     VARCHAR(15) NOT NULL,
    source                        VARCHAR(20) NOT NULL,
    variant                       VARCHAR(35) NOT NULL,
    new_cases                     INTEGER NOT NULL,
    number_sequenced              INTEGER NOT NULL,
    percent_cases_sequenced       DOUBLE NOT NULL,
    valid_denominator             VARCHAR(10) NOT NULL,
    number_detections_variant     INTEGER NOT NULL,
    percent_variant               INTEGER NOT NULL
);

ALTER TABLE variantes ADD CONSTRAINT variantes_pk PRIMARY KEY ( iso_code );

ALTER TABLE casos_confirmados
    ADD CONSTRAINT iso_code FOREIGN KEY ( iso_code )
        REFERENCES reportecovid ( iso_code );

ALTER TABLE muertes_covid
    ADD CONSTRAINT iso_codev1 FOREIGN KEY ( iso_code )
        REFERENCES reportecovid ( iso_code );

ALTER TABLE hospitalizaciones
    ADD CONSTRAINT iso_codev2 FOREIGN KEY ( iso_code )
        REFERENCES reportecovid ( iso_code );

ALTER TABLE pruebas
    ADD CONSTRAINT iso_codev3 FOREIGN KEY ( iso_code )
        REFERENCES reportecovid ( iso_code );

ALTER TABLE vacunados
    ADD CONSTRAINT iso_codev4 FOREIGN KEY ( iso_code )
        REFERENCES reportecovid ( iso_code );

ALTER TABLE variable_socioeconomicas
    ADD CONSTRAINT iso_codev5 FOREIGN KEY ( iso_code )
        REFERENCES reportecovid ( iso_code );

ALTER TABLE pais_variantes
    ADD CONSTRAINT pais_variantes_reportecovid_fk FOREIGN KEY ( iso_code1 )
        REFERENCES reportecovid ( iso_code );
