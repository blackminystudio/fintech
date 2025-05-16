reset:
	rm -f pubspec.lock
	yes | flutter pub cache clean
	flutter clean && flutter pub get

build:
	flutter build apk

test:
	flutter test
