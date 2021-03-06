#
# This file is part of the pinterest-ruby gem. Copyright (C) 2017 and above Shogun <shogun@cowtech.it>.
# Licensed under the MIT license, which can be found at https://choosealicense.com/licenses/mit.
#

require "spec_helper"

describe Pinterest::Board do
  context ".create" do
    it "should create a object" do
      expect(Pinterest::Board.create({})).to be_a(Pinterest::Board)
    end

    it "should parse dates" do
      expect(Pinterest::Board.create({"created_at" => "2015-11-16T12:34:56+00:00"}).created_at).to eq(DateTime.civil(2015, 11, 16, 12, 34, 56))
    end

    it "should create relationships" do
      expect(Pinterest::User).to receive(:create).with("CREATOR").and_return("CREATOR-OBJ")
      expect(Pinterest::Image).to receive(:new).with("IMAGE").and_return("IMAGE-OBJ")

      subject = Pinterest::Board.create({"creator" => "CREATOR", "image" => "IMAGE"})
      expect(subject.creator).to eq("CREATOR-OBJ")
      expect(subject.image).to eq("IMAGE-OBJ")
    end
  end

  context "#as_json" do
    it "should return a hash" do
      expect(Pinterest::User).to receive(:create).with("CREATOR").and_return("CREATOR-OBJ")
      expect(Pinterest::Image).to receive(:new).with("IMAGE").and_return("IMAGE-OBJ")

      expect(Pinterest::Board.create({
        "id" => "ID", "name" => "NAME", "url" => "URL", "description" => "DESCRIPTION",
        "creator" => "CREATOR", "created_at" => "2015-11-16T12:34:56+00:00", "counts" => "COUNTS", "image" => "IMAGE"
      }).as_json).to eq({
        id: "ID",
        name: "NAME",
        url: "URL",
        description: "DESCRIPTION",
        creator: "CREATOR-OBJ",
        created_at: DateTime.civil(2015, 11, 16, 12, 34, 56),
        counts: "COUNTS",
        image: "IMAGE-OBJ"
      })
    end
  end
end