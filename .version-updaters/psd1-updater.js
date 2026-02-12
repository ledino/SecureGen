module.exports.readVersion = function (contents) {
  const match = contents.match(/ModuleVersion\s*=\s*['"]([0-9.]+)['"]/);
  return match ? match[1] : null;
};

module.exports.writeVersion = function (contents, version) {
  return contents.replace(
    /ModuleVersion\s*=\s*['"]([0-9.]+)['"]/,
    `ModuleVersion = '${version}'`
  );
};