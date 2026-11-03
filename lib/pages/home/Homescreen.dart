import 'package:flutter/material.dart';
import '../import_export/ImportExportPage.dart';
import '../add_cow/AddCowPage.dart';
import '../cow_details/CowDetailsPage.dart';
import '../../api/Database_helper.dart';
import '../../models/cow_model.dart';
import 'package:nowa_runtime/nowa_runtime.dart';

class MyHomeScreen extends StatefulWidget {
  final int role; // Add a role parameter

  MyHomeScreen({required this.role}); // Constructor to accept role

  @override
  _MyHomeScreenState createState() => _MyHomeScreenState();
}

@NowaGenerated()
class _MyHomeScreenState extends State<MyHomeScreen> {
  final InventoryDatabaseHelper _dbHelper = InventoryDatabaseHelper();

  final TextEditingController _searchController = TextEditingController();

  List<Cow> _allCows = [];

  List<Cow> _filteredCows = [];

  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchCows();
    _searchController.addListener(_onSearchChanged);
  }

  @override
  void dispose() {
    _searchController.removeListener(_onSearchChanged);
    _searchController.dispose();
    super.dispose();
  }

  Future<void> _fetchCows() async {
    setState(() => _isLoading = true);
    try {
      final cows = await _dbHelper.getAllCowsAsModels();
      setState(() {
        _allCows = cows;
        _filteredCows = cows;
        _isLoading = false;
      });
    } catch (e) {
      setState(() => _isLoading = false);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(
          'Error loading cows: ${e}',
        ),
        backgroundColor: Colors.red,
      ));
    }
  }

  void _onSearchChanged() {
    final query = _searchController.text.toLowerCase().trim();
    setState(() {
      if (query.isEmpty) {
        _filteredCows = _allCows;
      } else {
        _filteredCows = _allCows
            .where((cow) =>
                cow.name.toLowerCase().contains(query) ||
                cow.id.toLowerCase().contains(query) ||
                cow.breed.toLowerCase().contains(query))
            .toList();
      }
    });
  }

  void _clearSearch() {
    _searchController.clear();
  }

  Future<void> _navigateToAddCow() async {
    final result = await Navigator.push(
        context, MaterialPageRoute(builder: (context) => AddCowPage()));
    if (result == true) {
      await _fetchCows();
    }
  }

  Future<void> _navigateToCowDetails(Cow cow) async {
    await Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => CowDetailsPage(
                  cowName: cow.name,
                  cowId: cow.id,
                  cowBreed: cow.breed,
                  cowGender: cow.gender,
                  role: widget.role,
                )));
    await _fetchCows();
  }

  Widget _buildCowCard(Cow cow) {
    return Card(
      elevation: 4.0,
      margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 6.0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
      child: InkWell(
        borderRadius: BorderRadius.circular(12.0),
        onTap: () => _navigateToCowDetails(cow),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12.0),
                decoration: BoxDecoration(
                    color: cow.isAlive ? Colors.green[50] : Colors.red[50],
                    borderRadius: BorderRadius.circular(12.0)),
                child: Icon(
                  Icons.pets,
                  color: cow.isAlive ? Colors.green : Colors.red,
                  size: 28.0,
                ),
              ),
              const SizedBox(
                width: 16.0,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      cow.name,
                      style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey[800],
                      ),
                    ),
                    const SizedBox(
                      height: 4.0,
                    ),
                    Text(
                      'ID: ${cow.id}',
                      style: TextStyle(
                        fontSize: 14.0,
                        color: Colors.grey[600],
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(
                      height: 2.0,
                    ),
                    Row(
                      children: [
                        const SizedBox(
                          width: 4.0,
                        ),
                        Text(
                          cow.breed,
                          style: TextStyle(
                              fontSize: 12.0, color: Colors.grey[500]),
                        )
                      ],
                    )
                  ],
                ),
              ),
              Column(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 8.0, vertical: 4.0),
                    decoration: BoxDecoration(
                        color: cow.isAlive ? Colors.green : Colors.red,
                        borderRadius: BorderRadius.circular(12.0)),
                    child: Text(
                      cow.isAlive ? 'Alive' : 'Deceased',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 10.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 8.0,
                  ),
                  Icon(
                    Icons.arrow_forward_ios,
                    size: 16.0,
                    color: Colors.grey[400],
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        elevation: 0.0,
        actions: [
          if (widget.role == 1)
            IconButton(
              icon: const Icon(
                Icons.add,
              ),
              tooltip: 'Add Cow',
              onPressed: _navigateToAddCow,
            )
        ],
        title: SizedBox(
          width: 9999.0,
          child: Opacity(
            opacity: 0.9,
            alwaysIncludeSemantics: true,
            child: Text(
              'FarMan',
              style: TextStyle(
                fontSize: 30.0,
                fontWeight: FontWeight.w900,
                shadows: [],
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(16.0),
            decoration: const BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(24.0),
                    bottomRight: Radius.circular(24.0))),
            child: Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12.0),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 8.0,
                        offset: const Offset(0.0, 2.0),
                      )
                    ],
                  ),
                  child: TextField(
                    controller: _searchController,
                    decoration: InputDecoration(
                      hintText: 'Search by name, ID or breed...',
                      prefixIcon: const Icon(
                        Icons.search,
                        color: Colors.blue,
                      ),
                      suffixIcon: _searchController.text.isNotEmpty
                          ? IconButton(
                              icon: const Icon(
                                Icons.clear,
                                color: Colors.grey,
                              ),
                              onPressed: _clearSearch,
                            )
                          : null,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.0),
                          borderSide: BorderSide.none),
                      filled: true,
                      fillColor: Colors.white,
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16.0, vertical: 12.0),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 12.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '${_filteredCows.length} cow${_filteredCows.length != 1 ? 's' : ''} found',
                      style: const TextStyle(
                          color: Colors.white70, fontSize: 14.0),
                    ),
                    if (_searchController.text.isNotEmpty)
                      Text(
                        'Searching: "${_searchController.text}"',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 12.0,
                          fontStyle: FontStyle.italic,
                        ),
                      )
                  ],
                )
              ],
            ),
          ),
          FlexSizedBox(
            width: 393.0,
            height: 582.0,
            child: _isLoading
                ? const Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircularProgressIndicator(
                          color: Colors.blue,
                        ),
                        SizedBox(
                          height: 16.0,
                        ),
                        Text(
                          'Loading cows...',
                        )
                      ],
                    ),
                  )
                : _filteredCows.isEmpty
                    ? Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              _allCows.isEmpty
                                  ? Icons.pets_outlined
                                  : Icons.search_off,
                              size: 64.0,
                              color: Colors.grey[400],
                            ),
                            const SizedBox(
                              height: 16.0,
                            ),
                            Text(
                              _allCows.isEmpty
                                  ? 'No cows added yet'
                                  : 'No cows match your search',
                              style: TextStyle(
                                fontSize: 18.0,
                                color: Colors.grey[600],
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            const SizedBox(
                              height: 8.0,
                            ),
                            Text(
                              _allCows.isEmpty
                                  ? 'Tap the + button to add your first cow'
                                  : 'Try adjusting your search terms',
                              style: TextStyle(
                                  fontSize: 14.0, color: Colors.grey[500]),
                            )
                          ],
                        ),
                      )
                    : RefreshIndicator(
                        onRefresh: _fetchCows,
                        child: ListView.builder(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          itemCount: _filteredCows.length,
                          itemBuilder: (context, index) =>
                              _buildCowCard(_filteredCows[index]),
                        ),
                      ),
          )
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          const BottomNavigationBarItem(
              icon: Icon(
                Icons.home,
              ),
              label: 'Home'),
          const BottomNavigationBarItem(
              icon: Icon(
                Icons.calculate_sharp,
              ),
              label: 'Money'),
          const BottomNavigationBarItem(
              icon: Icon(
                Icons.import_export_outlined,
              ),
              label: 'Import/Export')
        ],
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white70,
        backgroundColor: Colors.blue,
        onTap: (index) {
          if (index == 0) {
          } else if (index == 1) {
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              content: Text(
                'Money feature coming soon!',
              ),
            ));
          } else if (index == 2) {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => ImportExportPage()));
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _navigateToAddCow();
        },
        child: const Icon(
          IconData(57415, fontFamily: 'MaterialIcons'),
        ),
      ),
    );
  }
}
