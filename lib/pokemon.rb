class Pokemon
    attr_accessor :name, :type, :db
    attr_reader :id

    def initialize(id:, name:, type:, db:)
        @id = id
        @name = name
        @type = type
        @db = db
    end

    def self.save(name, type, db)
        sql = <<-SQL
            INSERT INTO pokemon (name, type)
            VALUES (?, ?)
        SQL

        db.execute(sql, name, type)
        # @id = db.execute("SELECT last_insert_rowid() FROM pokemon")
    end

    def self.find(id, db)
        sql = <<-SQL
            SELECT *
            FROM pokemon
            WHERE id = ?
        SQL

        pokemon = db.execute(sql, id).flatten
        Pokemon.new(id: pokemon[0], name: pokemon[1], type: pokemon[2], db: pokemon[3])
    end

end

