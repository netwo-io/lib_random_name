create or replace function lib_random_name.rand_int(min_inclusive double precision, max_inclusive double precision) returns integer as
$$
declare
begin
    return floor(random() * ((max_inclusive - min_inclusive) + 1) + min_inclusive)::int;
end;
$$ security definer language plpgsql;
comment on function lib_random_name.rand_int(double precision, double precision) is $$Generate a random integer between min (inclusive) and max (inclusive)$$;

drop function if exists lib_random_name.sample(text[]);
create or replace function lib_random_name.sample(list$ text[]) returns text as
$$
declare
begin
    return list$[lib_random_name.rand_int(0, array_upper(list$, 1))];
end;
$$ security definer language plpgsql;

comment on function lib_random_name.sample(text[]) is $$Gets a random element from a list$$;

create or replace function lib_random_name.gen(token_length$ int default 4, delimiter$ text default '-',
                                               adjectives$ text[] default array [
                                                   'aged', 'ancient', 'autumn', 'billowing', 'bitter', 'black', 'blue', 'bold',
                                                   'broad', 'broken', 'calm', 'cold', 'cool', 'crimson', 'curly', 'damp',
                                                   'dark', 'dawn', 'delicate', 'divine', 'dry', 'empty', 'falling', 'fancy',
                                                   'flat', 'floral', 'fragrant', 'frosty', 'gentle', 'green', 'hidden', 'holy',
                                                   'icy', 'jolly', 'late', 'lingering', 'little', 'lively', 'long', 'lucky',
                                                   'misty', 'morning', 'muddy', 'mute', 'nameless', 'noisy', 'odd', 'old',
                                                   'orange', 'patient', 'plain', 'polished', 'proud', 'purple', 'quiet', 'rapid',
                                                   'raspy', 'red', 'restless', 'rough', 'round', 'royal', 'shiny', 'shrill',
                                                   'shy', 'silent', 'small', 'snowy', 'soft', 'solitary', 'sparkling', 'spring',
                                                   'square', 'steep', 'still', 'summer', 'super', 'sweet', 'throbbing', 'tight',
                                                   'tiny', 'twilight', 'wandering', 'weathered', 'white', 'wild', 'winter', 'wispy',
                                                   'withered', 'yellow', 'young'
                                                   ], nouns$ text[] default array [
        'art', 'band', 'bar', 'base', 'bird', 'block', 'boat', 'bonus',
        'bread', 'breeze', 'brook', 'bush', 'butterfly', 'cake', 'cell', 'cherry',
        'cloud', 'credit', 'darkness', 'dawn', 'dew', 'disk', 'dream', 'dust',
        'feather', 'field', 'fire', 'firefly', 'flower', 'fog', 'forest', 'frog',
        'frost', 'glade', 'glitter', 'grass', 'hall', 'hat', 'haze', 'heart',
        'hill', 'king', 'lab', 'lake', 'leaf', 'limit', 'math', 'meadow',
        'mode', 'moon', 'morning', 'mountain', 'mouse', 'mud', 'night', 'paper',
        'pine', 'poetry', 'pond', 'queen', 'rain', 'recipe', 'resonance', 'rice',
        'river', 'salad', 'scene', 'sea', 'shadow', 'shape', 'silence', 'sky',
        'smoke', 'snow', 'snowflake', 'sound', 'star', 'sun', 'sun', 'sunset',
        'surf', 'term', 'thunder', 'tooth', 'tree', 'truth', 'union', 'unit',
        'violet', 'voice', 'water', 'waterfall', 'wave', 'wildflower', 'wind', 'wood'
        ]) returns text as
$$
declare
    token$ text;
begin
    -- https://github.com/Atrox/haikunatorjs/blob/master/src/index.ts

    if token_length$ > 0 then
        token$ = lib_random_name.rand_int(pow(10, token_length$ - 1), pow(10, token_length$));
    end if;

    return concat_ws(delimiter$, lib_random_name.sample(nouns$), lib_random_name.sample(adjectives$), token$);
    --  select row_to_json(predicate_trees) from lib_random_name.predicate_trees where id = predicate_tree__id$ limit 1 into predicate_trees$;
--  return lib_random_name.gen(predicate_trees$->'predicates');
end;
$$ language plpgsql;
comment on function lib_random_name.gen(int, text, text[], text[]) is $$Generate a Heroku-like random name$$;
