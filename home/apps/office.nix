{ pkgs, lib, ... }:

let
  writer = "office-writer.desktop";
  calc = "office-calc.desktop";
  impress = "office-impress.desktop";
  pdfViewer = "pdf-viewer.desktop";
in
{
  home.packages = with pkgs; [
    # Office
    libreoffice-qt
    hunspell
    hunspellDicts.pt_BR
    hunspellDicts.en_US

    # PDF
    evince
    pdfarranger
    xournalpp
  ];

  xdg.desktopEntries = {
    office-writer = {
      name = "LibreOffice Writer";
      exec = "${pkgs.libreoffice-qt}/bin/libreoffice --writer %U";
      icon = "libreoffice-writer";
      terminal = false;
      noDisplay = true;
      categories = [ "Office" "WordProcessor" ];
      mimeType = [
        "application/msword"
        "application/vnd.openxmlformats-officedocument.wordprocessingml.document"
        "application/vnd.oasis.opendocument.text"
        "application/rtf"
      ];
    };

    office-calc = {
      name = "LibreOffice Calc";
      exec = "${pkgs.libreoffice-qt}/bin/libreoffice --calc %U";
      icon = "libreoffice-calc";
      terminal = false;
      noDisplay = true;
      categories = [ "Office" "Spreadsheet" ];
      mimeType = [
        "application/vnd.ms-excel"
        "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet"
        "application/vnd.oasis.opendocument.spreadsheet"
        "text/csv"
      ];
    };

    office-impress = {
      name = "LibreOffice Impress";
      exec = "${pkgs.libreoffice-qt}/bin/libreoffice --impress %U";
      icon = "libreoffice-impress";
      terminal = false;
      noDisplay = true;
      categories = [ "Office" "Presentation" ];
      mimeType = [
        "application/vnd.ms-powerpoint"
        "application/vnd.openxmlformats-officedocument.presentationml.presentation"
        "application/vnd.oasis.opendocument.presentation"
      ];
    };

    pdf-viewer = {
      name = "Evince";
      exec = "${pkgs.evince}/bin/evince %U";
      icon = "org.gnome.Evince";
      terminal = false;
      noDisplay = true;
      categories = [ "Office" "Viewer" ];
      mimeType = [
        "application/pdf"
      ];
    };
  };

  xdg.mimeApps = {
    enable = true;

    defaultApplications = {
      "application/pdf" = lib.mkForce pdfViewer;
      "application/msword" = writer;
      "application/vnd.openxmlformats-officedocument.wordprocessingml.document" = writer;
      "application/vnd.oasis.opendocument.text" = writer;
      "application/rtf" = writer;
      "application/vnd.ms-excel" = calc;
      "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet" = calc;
      "application/vnd.oasis.opendocument.spreadsheet" = calc;
      "text/csv" = calc;
      "application/vnd.ms-powerpoint" = impress;
      "application/vnd.openxmlformats-officedocument.presentationml.presentation" = impress;
      "application/vnd.oasis.opendocument.presentation" = impress;
    };
  };
}