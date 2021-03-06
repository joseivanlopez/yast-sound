# encoding: utf-8

# File:
#  test_routines.ycp
#
# Module:
#  Sound
#
# Summary:
#  Tests for sound includes.
#
# Authors:
#  Dan Meszaros <dmeszar@suse.cz>, 2001
#
# Tests for sound routines.
module Yast
  class FilterConfiguredClient < Client
    def main
      Yast.import "UI"
      # testedfiles: Sound.ycp sound/routines.ycp

      Yast.include self, "testsuite.rb"

      @READ_I = { "target" => { "size" => -1, "tmpdir" => "/tmp" } }

      TESTSUITE_INIT([@READ_I], nil)
      Yast.include self, "sound/routines.rb"

      @save_info = []
      @cards = []

      # in card entries we care about nothing but unique_key

      # empty save_info, no cards
      TEST(lambda { filter_configured(@save_info, @cards) }, [], nil)

      # one detected, no configured cards
      @save_info = []
      @cards = [
        {
          "device"     => "SB Live! EMU10000",
          "unique_key" => "CvwD.k1dGGUobcK9",
          "vendor"     => "Creative Labs",
          "vendor_id"  => 69890
        }
      ]
      TEST(lambda { filter_configured(@save_info, @cards) }, [], nil)

      # detected and configured card
      @save_info = [
        { "alias" => "", "module" => "", "unique_key" => "CvwD.k1dGGUobcK9" }
      ]
      TEST(lambda { filter_configured(@save_info, @cards) }, [], nil)

      # detected but different that configured

      @save_info = [
        { "alias" => "", "module" => "", "unique_key" => "cVWd.K1DgguOBCk9" }
      ]
      TEST(lambda { filter_configured(@save_info, @cards) }, [], nil)

      # two detected cards

      @cards = [
        {
          "bus"           => "PCI",
          "class_id"      => 4,
          "device"        => "SB Live! EMU10000",
          "device_id"     => 65538,
          "drivers"       => [
            {
              "active"   => false,
              "modprobe" => true,
              "modules"  => [["emu10k1", ""]]
            }
          ],
          "resource"      => {
            "io"  => [
              {
                "active" => true,
                "length" => 0,
                "mode"   => "rw",
                "start"  => 49152
              }
            ],
            "irq" => [{ "count" => 1146364, "enabled" => true, "irq" => 10 }]
          },
          "rev"           => "7",
          "sub_class_id"  => 1,
          "sub_device"    => "CT4830 SBLive! Value",
          "sub_device_id" => 98342,
          "sub_vendor"    => "Creative Labs",
          "sub_vendor_id" => 69890,
          "unique_key"    => "CvwD.k1dGGUobcK9",
          "vendor"        => "Creative Labs",
          "vendor_id"     => 69890
        },
        {
          "bus"           => "PCI",
          "class_id"      => 4,
          "device"        => "AC97 Audio Controller",
          "device_id"     => 77912,
          "drivers"       => [
            {
              "active"   => false,
              "modprobe" => true,
              "modules"  => [["via82cxxx_audio", ""]]
            }
          ],
          "resource"      => {
            "io"  => [
              {
                "active" => true,
                "length" => 0,
                "mode"   => "rw",
                "start"  => 55296
              },
              {
                "active" => true,
                "length" => 0,
                "mode"   => "rw",
                "start"  => 56320
              },
              {
                "active" => true,
                "length" => 0,
                "mode"   => "rw",
                "start"  => 57344
              }
            ],
            "irq" => [{ "count" => 1146364, "enabled" => true, "irq" => 10 }]
          },
          "rev"           => "32",
          "sub_class_id"  => 1,
          "sub_device_id" => 100613,
          "sub_vendor"    => "FIRST INTERNATIONAL Computer Inc",
          "sub_vendor_id" => 70921,
          "unique_key"    => "hB6S.CxYdteFTb8D",
          "vendor"        => "VIA Technologies, Inc.",
          "vendor_id"     => 69894
        }
      ]
      # both configured
      @save_info = [
        { "unique_key" => "hB6S.CxYdteFTb8D" },
        { "unique_key" => "CvwD.k1dGGUobcK9" }
      ]

      TEST(lambda { filter_configured(@save_info, @cards) }, [], nil)

      # first not configured
      @save_info = [
        { "unique_key" => "hB6S.CxYdteFTb8D" },
        { "unique_key" => "cVWd.K1DgguOBCk9" }
      ]
      TEST(lambda { filter_configured(@save_info, @cards) }, [], nil)

      # none configured
      @save_info = []
      TEST(lambda { filter_configured(@save_info, @cards) }, [], nil)

      nil
    end
  end
end

Yast::FilterConfiguredClient.new.main
