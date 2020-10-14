create or replace function lib_test.test_case_lib_random_name_gen_no_token_length() returns void
    language plpgsql
as
$$
declare
begin
    -- re-init randomness to predefined
    perform SETSEED(0.5);
    perform lib_test.assert_equal(lib_random_name.gen(token_length$ => 0), 'dust-odd');
    perform SETSEED(0.1);
    perform lib_test.assert_equal(lib_random_name.gen(token_length$ => 0), 'term-round');
end;
$$;

create or replace function lib_test.test_case_lib_random_name_gen_with_custom_delimiter() returns void
    language plpgsql
as
$$
declare
begin
    -- re-init randomness to predefined
    perform SETSEED(0.5);
    perform lib_test.assert_equal(lib_random_name.gen(delimiter$ => ' '), 'moon morning 3249');
    perform SETSEED(0.1);
    perform lib_test.assert_equal(lib_random_name.gen(delimiter$ => ' ', token_length$ => 0), 'term round');
end;
$$;

create or replace function lib_test.test_case_lib_random_name_gen_with_one_token() returns void
    language plpgsql
as
$$
declare
begin
    -- re-init randomness to predefined
    perform SETSEED(0.5);
    perform lib_test.assert_equal(lib_random_name.gen(token_length$ => 1), 'moon-morning-3');
    perform lib_test.assert_equal(lib_random_name.gen(token_length$ => 1), 'cloud-black-3');
    perform lib_test.assert_equal(lib_random_name.gen(token_length$ => 1), 'fire-cool-2');
    perform lib_test.assert_equal(lib_random_name.gen(token_length$ => 1), 'cell-yellow-7');
end;
$$;

create or replace function lib_test.test_case_lib_random_name_gen_with_two_token() returns void
    language plpgsql
as
$$
declare
    results$ text[];
    result$  text;
begin
    -- re-init randomness to predefined
    perform SETSEED(0.5);

    results$ = array [
        'moon-morning-32',
        'cloud-black-30',
        'fire-cool-21',
        'cell-yellow-67',
        'glitter-solitary-79',
        'bonus-crimson-89',
        'thunder-empty-55',
        'hall-plain-44',
        'bread-rapid-28',
        'truth-purple-72',
        'hall-shrill-13',
        'tree-yellow-84',
        'dream-floral-31',
        'sea-aged-85',
        'mode-calm-27',
        'dew-dawn-91',
        'feather-falling-72',
        'boat-withered-53',
        'flower-dry-48',
        'mountain-curly-39',
        'union-solitary-78',
        'tree-winter-59',
        'lab-restless-58',
        'dust-flat-34',
        'field-tiny-70',
        'tree-misty-56',
        'brook-tiny-95',
        'leaf-billowing-61',
        'meadow-empty-53',
        'sky-curly-91',
        'pine-winter-14',
        'disk-billowing-28',
        'sea-ancient-32',
        'water-floral-71',
        'moon-broad-27',
        'bush-little-98',
        'paper-throbbing-39',
        'disk-lucky-76',
        'dawn-patient-26',
        'shadow-summer-86',
        'wildflower-dawn-66',
        'cherry-wandering-86',
        'bar-nameless-61',
        'night-dark-39',
        'breeze-dawn-21',
        'sound-purple-96',
        'brook-white-10',
        'breeze-tight-79',
        'scene-bold-28',
        'cherry-wispy-25',
        'wood-lucky-71',
        'lake-15',
        'block-tight-29',
        'cherry-shiny-34',
        'snowflake-damp-57',
        'dream-wandering-12',
        'scene-muddy-96',
        'wildflower-floral-40',
        'disk-floral-67',
        'poetry-broad-12',
        'poetry-bold-34',
        'sun-summer-68',
        'sea-fancy-51',
        'limit-divine-90',
        'queen-crimson-32',
        'bonus-bitter-41',
        'surf-dark-46',
        'frog-noisy-73',
        'voice-dark-82',
        'dawn-shy-97',
        'bar-still-39',
        'leaf-proud-58',
        'sun-divine-97',
        'feather-gentle-42',
        'surf-damp-83',
        'violet-empty-70',
        'term-still-98',
        'bar-solitary-12',
        'wind-dark-87',
        'breeze-fancy-29',
        'breeze-jolly-94',
        'breeze-tiny-45',
        'thunder-gentle-45',
        'leaf-still-23',
        'moon-dark-59',
        'wave-steep-64',
        'smoke-shiny-94',
        'snow-wispy-10',
        'haze-spring-53',
        'mouse-polished-92',
        'mountain-still-46',
        'bird-super-43',
        'boat-gentle-84',
        'dust-spring-68',
        'bar-morning-38',
        'glitter-falling-42',
        'truth-bitter-64',
        'limit-floral-11',
        'flower-damp-50',
        'art-broken-28'
        ];

    foreach result$ in array results$
        loop
            perform lib_test.assert_equal(lib_random_name.gen(token_length$ => 2), result$);
        end loop;
end;
$$;
