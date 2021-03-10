defmodule PassportChecker do

  @doc """
  PassportChecker.read_file("passports.txt")
  """

  defstruct ~w[byr iyr eyr hgt hcl ecl pid cid]a

  @require_fields ~w[byr iyr eyr hgt hcl ecl pid]a



  def read_file(path) do
    path
    |> File.read!()
    |> String.split("\n\n")
    |> Enum.map(fn x -> String.replace(x,"\n"," ") end)
    |> Enum.map(fn fields -> generetation_struct(fields) end )
    |> Enum.filter(fn passport -> validate_passport(passport) end )
    |> Enum.count()
  end

  def generetation_struct(fields) do
    fields
    |> String.split(" ")
    |> Enum.map(fn field -> String.split(field, ":") end)
    |> Enum.reduce(%PassportChecker{}, fn x, acc ->
      Map.put(acc,String.to_atom(Enum.at(x,0)), Enum.at(x,1))
    end)
  end

  def validate_passport(passport) do
    fields_empty =
      Enum.map(@require_fields, fn field -> missing_field?(passport,field)end )
    case fields_empty do
      [false, false, false, false, false, false, false] ->
          true
      _  ->
          false
    end
  end

  def missing_field?(passport, field) when is_atom(field) do
    case get_field(passport, field) do
      nil -> true
      value -> !validate_field_format(value, field)
    end
  end

  def validate_field_format(value, field) when field == :byr do
      Regex.match?(~r/^(19[2-9]{1}[0-9]{1}|200[0-2]{1})$/u, value)
  end

  def validate_field_format(value, field) when field == :iyr do
      Regex.match?(~r/^(201[0-9]{1}|2020)$/u, value)
  end

  def validate_field_format(value, field) when field == :eyr do
      Regex.match?(~r/^(202[0-9]{1}|2030)$/u, value)
  end

  def validate_field_format(value, field) when field == :hgt do
      Regex.match?(~r/^(1(([5-8]{1}[0-9]{1})|(9[0-3]))cm|(59|(6[0-9]{1})|(7[0-6]))in)$/u, value)
  end

  def validate_field_format(value, field) when field == :hcl do
      Regex.match?(~r/^\#(([a-f0-9]){6})$/u, value)
  end

  def validate_field_format(value, field) when field == :pid do
      Regex.match?(~r/^([0-9]){9}$/u, value)
  end

  def validate_field_format(value, field) when field == :ecl do
      Regex.match?(~r/^(amb|blu|brn|gry|grn|hzl|oth)$/u, value)
  end


  def get_field(passport, key) do
    case Map.fetch(passport, key) do
      {:ok, value} ->
        value
      :error ->
        nil
    end
  end

end
