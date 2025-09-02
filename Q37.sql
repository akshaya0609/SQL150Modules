-- Playlists
DROP TABLE IF EXISTS playlists;
CREATE TABLE playlists (
    playlist_id INT PRIMARY KEY,
    playlist_name VARCHAR(15)
);
INSERT INTO playlists (playlist_id, playlist_name) VALUES
(1, 'Chill Vibes'),
(2, 'Morning Jams'),
(3, 'Workout Beats'),
(4, 'Party Mix'),
(5, 'Study Playlist');
-- Playlist Tracks
DROP TABLE IF EXISTS playlist_tracks;
CREATE TABLE playlist_tracks (
    playlist_id INT,
    track_id INT
);
INSERT INTO playlist_tracks (playlist_id, track_id) VALUES
(1, 101),
(1, 102),
(1, 103),
(1, 104),
(2, 104),
(2, 102),
(3, 104),
(3, 107),
(4, 101),
(4, 104),
(5, 103);
-- Playlist Plays
DROP TABLE IF EXISTS playlist_plays;
CREATE TABLE playlist_plays (
    playlist_id INT,
    user_id VARCHAR(2)
);
INSERT INTO playlist_plays (playlist_id, user_id) VALUES
(1, 'u1'),
(1, 'u2'),
(2, 'u3'),
(3, 'u3'),
(3, 'u1'),
(1, 'u4'),
(4, 'u1'),
(4, 'u2'),
(5, 'u3'),
(5, 'u1');


SELECT pt.track_id, COUNT(DISTINCT pt.playlist_id) AS playlist_count FROM playlist_tracks AS pt
WHERE pt.playlist_id IN (
  SELECT playlist_id
  FROM playlist_plays
  GROUP BY playlist_id
  HAVING COUNT(user_id) >= 2
)
GROUP BY pt.track_id
ORDER BY playlist_count DESC, pt.track_id DESC
LIMIT 2;
